require("rake_helper_methods_cc.rb")
require("rake_helper_methods_qi.rb")
require("rake_helper_methods_qg.rb")
require("rake_helper_methods_others.rb")
include PutsControlConstruct
include PutsQuestionItems
include PutsQuestionGrids
include PutsOthers

namespace :ddi do

desc "Output ddi3.2 from the environment"
task :output_ddi32 => [:environment, 
			:controller_variables,
			:puts_open_instance_and_RP,
			:puts_instruction_scheme,
			:puts_cc_scheme,
			:puts_question_items,
			:puts_question_grids,
			:puts_categories,
			:puts_code_schemes,
			:puts_instrument_scheme] do
  puts "  </g:ResourcePackage>"
  puts "</ddi:DDIInstance>"
end

# "Assignments that are in the caddies controllers"
task :controller_variables do
  @date_stamp = DateTime.now
  @instance = Instance.first
  @output_option = "Metadata originally captured using CADDIES(Centre for Longitudinal Studies) version 0.12.6 with the xml rake option"
  @question_items = QuestionItem.all_used_in_top_sequence
  @question_grids = QuestionGrid.all_used_in_top_sequence
  @instructions = Instruction.all_used_in_top_sequence(@question_items, @question_grids)
  @code_schemes = CodeScheme.all_used_in_top_sequence(@question_items, @question_grids)
  @categories = Category.all_used_in_top_sequence(@code_schemes)
  @first_construct = CcAll.find(1)
end

# "Puts the opening Instance and ResourcePackage xml"
task :puts_open_instance_and_RP do
  puts "<ddi:DDIInstance versionDate=\"#{@date_stamp}\" xmlns:d=\"ddi:datacollection:3_2\" xmlns:ddi=\"ddi:instance:3_2\" xmlns:g=\"ddi:group:3_2\" xmlns:l=\"ddi:logicalproduct:3_2\" xmlns:r=\"ddi:reusable:3_2\">"
  puts "  <r:URN>urn:ddi:#{@instance.agency}:#{@instance.urn_id}:#{@instance.version}</r:URN>"
  puts "  <r:Citation>"
  puts "    <r:Title><r:String xml:lang=\"en-GB\">#{@instance.inst_citation}</r:String></r:Title>"
  puts "    <r:SubTitle><r:String xml:lang=\"en-GB\">#{@output_option}</r:String></r:SubTitle>"
  puts "  </r:Citation>"
  puts ""
  puts "  <g:ResourcePackage versionDate=\"#{@date_stamp}\">"
  puts "    <r:URN>urn:ddi:#{@instance.agency}:#{@instance.resource_package_urn_id}:#{@instance.version}</r:URN>"
  puts "    <r:Citation>"
  puts "      <r:Title><r:String xml:lang=\"en-GB\">#{@instance.rp_citation}</r:String></r:Title>"
  puts "    </r:Citation>"
  puts "    <r:Purpose>"
  puts "      <r:Content xml:lang=\"en-GB\">#{@instance.purpose_text}</r:Content>"
  puts "    </r:Purpose>"
  puts ""
end

# "Puts the InstructionScheme"
task :puts_instruction_scheme do
  puts "    <d:InterviewerInstructionScheme versionDate=\"#{@date_stamp}\">"
  puts "      <r:URN>urn:ddi:#{@instance.agency}:#{@instance.interviewer_instruction_scheme_urn_id}:#{@instance.version}</r:URN>"
  puts "      <d:InterviewerInstructionSchemeName><r:String xml:lang=\"en-GB\">#{@instance.instruction_scheme}</r:String></d:InterviewerInstructionSchemeName>"
  @instructions.each do |instruction|
  puts "      <d:Instruction>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{instruction.urn_id}:#{@instance.version}</r:URN>"
  puts "        <d:InstructionText audienceLanguage=\"en-GB\">"
  puts "    	  <d:LiteralText>"
  puts "    	    <d:Text>#{instruction.instruction_text}</d:Text>"
  puts "    	  </d:LiteralText>"
  puts "        </d:InstructionText>"
  puts "      </d:Instruction>"
  end
  puts "    </d:InterviewerInstructionScheme>"
  puts ""
end

# "Puts the ControlConstructScheme"
task :puts_cc_scheme do
  puts "    <d:ControlConstructScheme>"
  puts "      <r:URN>urn:ddi:#{@instance.agency}:#{@instance.control_construct_scheme_urn_id}:#{@instance.version}</r:URN>"
  puts "      <d:ControlConstructSchemeName><r:String xml:lang=\"en-GB\">#{@instance.cc_scheme}</r:String></d:ControlConstructSchemeName>"
  puts_control_construct(@first_construct)
  puts "    </d:ControlConstructScheme>"
  puts ""
end

# "Puts the QuestionScheme for QuestionItems"
task :puts_question_items do
  puts_question_items(@question_items)
  puts ""
end

# "Puts the QuestionScheme for QuestionGrids"
task :puts_question_grids do
  puts_question_grids(@question_grids)
  puts ""
end

# "Puts the Categories"
task :puts_categories do
  puts "    <l:CategoryScheme versionDate=\"#{@date_stamp}\">"
  puts "      <r:URN>urn:ddi:#{@instance.agency}:#{@instance.category_scheme_urn_id}:#{@instance.version}</r:URN>"
  puts "      <l:CategorySchemeName><r:String  xml:lang=\"en-GB\">#{@instance.category_scheme}</r:String></l:CategorySchemeName>"
  @categories.each do |category|
  puts "      <l:Category>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{category.urn_id}:#{@instance.version}</r:URN>"
  puts "        <l:CategoryName><r:String xml:lang=\"en-GB\">#{category.id}</r:String></l:CategoryName>"
  puts "    	<r:Label>"
  puts "          <r:Content xml:lang=\"en-GB\">#{category.label}</r:Content>"
  puts "        </r:Label>"
  puts "      </l:Category>"
  end
  puts "    </l:CategoryScheme>"
  puts ""
end

# "Puts the CodeSchemes"
task :puts_code_schemes do
  puts "    <l:CodeListScheme versionDate=\"#{@date_stamp}\">"
  puts "      <r:URN>urn:ddi:#{@instance.agency}:#{@instance.code_list_scheme_urn_id}:#{@instance.version}</r:URN>"
  puts "      <l:CodeListSchemeName><r:String  xml:lang=\"en-GB\">#{@instance.code_list_scheme}</r:String></l:CodeListSchemeName>"
  @code_schemes.each do |code_list|
  puts "      <l:CodeList>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{code_list.urn_id}:#{@instance.version}</r:URN>"
  puts "        <r:Label>"
  puts "          <r:Content xml:lang=\"en-GB\">#{code_list.label}</r:Content>"
  puts "        </r:Label>"
    code_list.codes.each do |code|
  puts "        <l:Code>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{code.urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:CategoryReference>"
  puts "            <r:URN>urn:ddi:#{@instance.agency}:#{code.category.urn_id}:#{@instance.version}</r:URN>"
  puts "            <r:TypeOfObject>Category</r:TypeOfObject>"
  puts "          </r:CategoryReference>"
  puts "          <r:Value>#{code.cs_value}</r:Value>"
  puts "        </l:Code>"
    end
  puts "      </l:CodeList>"
  end
  puts "    </l:CodeListScheme>"
  puts ""
end

# "Puts the InstrumentScheme"
task :puts_instrument_scheme do
  puts "    <d:InstrumentScheme>"
  puts "      <r:URN>urn:ddi:#{@instance.agency}:#{@instance.instrument_scheme_urn_id}:#{@instance.version}</r:URN>"
  puts "      <d:InstrumentSchemeName><r:String xml:lang=\"en-GB\">#{@instance.instrument_scheme}</r:String></d:InstrumentSchemeName>"
  puts "      <d:Instrument>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{@instance.instrument_urn_id}:#{@instance.version}</r:URN>"
  puts "        <d:InstrumentName><r:String xml:lang=\"en-GB\">#{@instance.instrument}</r:String></d:InstrumentName>"
  puts "        <d:ControlConstructReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{@first_construct.construct.urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>Sequence</r:TypeOfObject>"
  puts "        </d:ControlConstructReference>"
  puts "      </d:Instrument>"
  puts "    </d:InstrumentScheme>"
  puts ""
end

task :default => [:output_ddi32]

end

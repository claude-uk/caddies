module PutsQuestionGrids

  def puts_question_grids(question_grids)
  puts "    <d:QuestionScheme versionDate=\"#{@date_stamp}\">"
  puts "      <r:URN>urn:ddi:#{@instance.agency}:#{@instance.question_grid_scheme_urn_id}:#{@instance.version}</r:URN>"
  puts "      <d:QuestionSchemeName><r:String xml:lang=\"en-GB\">#{@instance.question_grid_scheme}</r:String></d:QuestionSchemeName>"
 
    question_grids.each do |question_grid|
  puts "      <d:QuestionGrid>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{question_grid.urn_id}:#{@instance.version}</r:URN>"
  puts "        <r:UserAttributePair>"
  puts "          <r:AttributeKey>extension:Label</r:AttributeKey>"
  puts "          <r:AttributeValue>{\"en-GB\":\"#{question_grid.label}\"}</r:AttributeValue>"
  puts "        </r:UserAttributePair>"
  puts "        <d:QuestionGridName><r:String xml:lang=\"en-GB\">#{question_grid.textid}</r:String></d:QuestionGridName>"
  puts "        <d:QuestionText audienceLanguage=\"en-GB\">"
  puts "          <d:LiteralText>"
  puts "            <d:Text>#{question_grid.literal}</d:Text>"
  puts "          </d:LiteralText>"
  puts "        </d:QuestionText>"
  
      if question_grid.corner_label == "Vertical"
  puts "        <d:GridDimension rank=\"1\" displayCode=\"false\" displayLabel=\"true\">"
      else
  puts "        <d:GridDimension rank=\"1\" displayCode=\"false\" displayLabel=\"false\">"
      end
  
      if question_grid.vertical_codelist
  puts "          <d:CodeDomain>"
  puts "            <r:CodeListReference>"
  puts "              <r:URN>urn:ddi:#{@instance.agency}:#{question_grid.vertical_codelist.urn_id}:#{@instance.version}</r:URN>"
  puts "              <r:TypeOfObject>CodeList</r:TypeOfObject>"
  puts "            </r:CodeListReference>"
  puts "          </d:CodeDomain>"
      elsif (question_grid.vertical_roster_rows)
        if (question_grid.vertical_roster_rows > 0)
  puts "          <d:Roster baseCodeValue=\"1\" codeIterationValue=\"1\" minimumRequired=\"#{question_grid.vertical_roster_rows}\">"
        else
  puts "          <d:Roster baseCodeValue=\"1\" codeIterationValue=\"1\">"
        end
  puts "            <r:Label>"
  puts "              <r:Content xml:lang=\"en-GB\">#{question_grid.vertical_roster_label}</r:Content>"
  puts "            </r:Label>"
  puts "          </d:Roster>"
      end
  
  puts "        </d:GridDimension>"

      if question_grid.corner_label == "horizontal"
  puts "        <d:GridDimension rank=\"2\" displayCode=\"false\" displayLabel=\"true\">"
      else
  puts "        <d:GridDimension rank=\"2\" displayCode=\"false\" displayLabel=\"false\">"
      end
  
  puts "          <d:CodeDomain>"
  puts "            <r:CodeListReference>"
  puts "              <r:URN>urn:ddi:#{@instance.agency}:#{question_grid.horizontal_codelist.urn_id}:#{@instance.version}</r:URN>"
  puts "              <r:TypeOfObject>CodeList</r:TypeOfObject>"
  puts "            </r:CodeListReference>"
  puts "          </d:CodeDomain>"
  puts "        </d:GridDimension>"
  
      if (question_grid.response_domain_count > 1)
  puts "        <d:StructuredMixedGridResponseDomain>"
        question_grid.columns.collect{|c| c.response_domain_all}.each_with_index do |rda, index|
          if !rda.nil?
  puts "    	  <d:GridResponseDomain>"
            if rda.response_domain_type.id == 1
              texts_inline(rda.domain)
            elsif rda.response_domain_type.id == 2
              numerics_inline(rda.domain)
            elsif rda.response_domain_type.id == 3
              codes_reference(rda.domain.code_scheme)
            elsif rda.response_domain_type.id == 4
              datetimes_inline(rda.domain)
            end

  puts "            <d:GridAttachment>"
  puts "              <d:CellCoordinatesAsDefined>"
  puts "                <d:SelectDimension rank=\"1\" allValues=\"true\" />"
  puts "                <d:SelectDimension rank=\"2\" specificValue=\"#{index + 1}\" />"
  puts "              </d:CellCoordinatesAsDefined>"
  puts "            </d:GridAttachment>"
  puts "          </d:GridResponseDomain>"
          end
        end
  puts "        </d:StructuredMixedGridResponseDomain>"
  
      elsif question_grid.response_domain_count == 1
        rda_type = question_grid.columns.first.response_domain_all.response_domain_type.id
        rda_domain = question_grid.columns.first.response_domain_all.domain
        if rda_type == 1
          texts_inline(rda_domain)
        elsif rda_type == 2
          numerics_inline(rda_domain)
        elsif rda_type == 3
          codes_reference(rda_domain.code_scheme)
        elsif rda_type == 4
          datetimes_inline(rda_domain)
        end
      end

      if question_grid.instruction
  puts "        <d:InterviewerInstructionReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{question_grid.instruction.urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>Instruction</r:TypeOfObject>"
  puts "        </d:InterviewerInstructionReference>"
      end
  puts "      </d:QuestionGrid>"
    end

  puts "    </d:QuestionScheme>"
  end
end

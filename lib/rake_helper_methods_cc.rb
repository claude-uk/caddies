module PutsControlConstruct
  
  def puts_control_construct(xmlconstruct)  
    if xmlconstruct.construct_type == 'CcSequence'
  puts "      <d:Sequence>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.urn_id}:#{@instance.version}</r:URN>"
  safeputs "        <d:ConstructName><r:String xml:lang=\"en-GB\">#{xmlconstruct.construct.textid}</r:String></d:ConstructName>"
  puts "        <r:Label>"
  safeputs "    	  <r:Content xml:lang=\"en-GB\">#{xmlconstruct.construct.label}</r:Content>"
  puts "        </r:Label>"
      xmlconstruct.children.each do |cc_child|
  puts "        <d:ControlConstructReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{cc_child.construct.urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>#{cc_child.type_of_object}</r:TypeOfObject>"
  puts "        </d:ControlConstructReference>"
      end
  puts "      </d:Sequence>"
      xmlconstruct.children.each do |cc_child|
        puts_control_construct(cc_child)
      end

    elsif xmlconstruct.construct_type == 'CcStatement'
  puts "      <d:StatementItem>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.urn_id}:#{@instance.version}</r:URN>"
  safeputs "        <d:ConstructName><r:String xml:lang=\"en-GB\">#{xmlconstruct.construct.textid}</r:String></d:ConstructName>"
  puts "        <d:DisplayText audienceLanguage=\"en-GB\">"
  puts "          <d:LiteralText>"
  safeputs "            <d:Text>#{xmlconstruct.construct.statement_item}</d:Text>"
  puts "          </d:LiteralText>"
  puts "        </d:DisplayText>"
  puts "      </d:StatementItem>"

    elsif xmlconstruct.construct_type == 'CcQuestion'
  puts "      <d:QuestionConstruct>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.urn_id}:#{@instance.version}</r:URN>"
  safeputs "        <d:ConstructName><r:String xml:lang=\"en-GB\">#{xmlconstruct.construct.textid}</r:String></d:ConstructName>"
  puts "        <r:Label>"
  safeputs "    	  <r:Content xml:lang=\"en-GB\">#{xmlconstruct.construct.label}</r:Content>"
  puts "        </r:Label>"
  puts "        <r:QuestionReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.question_reference.urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>#{xmlconstruct.construct.question_reference.type_of_object}</r:TypeOfObject>"
  puts "        </r:QuestionReference>"
  puts "        <d:ResponseUnit>#{xmlconstruct.construct.response_unit.text}</d:ResponseUnit>"
  puts "      </d:QuestionConstruct>"

    elsif xmlconstruct.construct_type == 'CcLoop'
  puts "      <d:Loop>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.urn_id}:#{@instance.version}</r:URN>"
  safeputs "        <d:ConstructName><r:String xml:lang=\"en-GB\">#{xmlconstruct.construct.textid}</r:String></d:ConstructName>"
  puts "        <d:InitialValue>"
  puts "          <r:Command>"
  puts "            <r:ProgramLanguage>pseudo-code</r:ProgramLanguage>"
  puts "            <r:CommandContent>#{xmlconstruct.construct.xml_initial_value}</r:CommandContent>"
  puts "          </r:Command>"
  puts "        </d:InitialValue>"
  puts "        <d:LoopWhile>"
  puts "          <r:Command>"
  puts "            <r:ProgramLanguage>pseudo-code</r:ProgramLanguage>"
  puts "            <r:CommandContent>#{CGI.escapeHTML(xmlconstruct.construct.xml_loop_while)}</r:CommandContent>"
  puts "          </r:Command>"
  puts "        </d:LoopWhile>"
  puts "    	<d:ControlConstructReference>"
  puts "    	  <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.loop_sequence_urn_id}:#{@instance.version}</r:URN>"
  puts "    	  <r:TypeOfObject>Sequence</r:TypeOfObject>"
  puts "        </d:ControlConstructReference>"
  puts "      </d:Loop>"

  puts "      <d:Sequence>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.loop_sequence_urn_id}:#{@instance.version}</r:URN>"
  safeputs "        <d:ConstructName><r:String xml:lang=\"en-GB\">loop_seq_#{xmlconstruct.construct.textid}</r:String></d:ConstructName>"
  puts "        <r:Label>"
  safeputs "    	  <r:Content xml:lang=\"en-GB\">loop_seq_#{xmlconstruct.construct.textid}</r:Content>"
  puts "        </r:Label>"
      xmlconstruct.children.each do |cc_child|
  puts "        <d:ControlConstructReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{cc_child.construct.urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>#{cc_child.type_of_object}</r:TypeOfObject>"
  puts "        </d:ControlConstructReference>"
      end
  puts "      </d:Sequence>"

      xmlconstruct.children.each do |cc_child|
        puts_control_construct(cc_child)
      end

    elsif xmlconstruct.construct_type == 'CcIfthenelse'
  puts "      <d:IfThenElse>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.urn_id}:#{@instance.version}</r:URN>"
  safeputs "        <d:ConstructName><r:String xml:lang=\"en-GB\">#{xmlconstruct.construct.textid}</r:String></d:ConstructName>"
  puts_if_condition(xmlconstruct.construct.condition)
  puts "        <d:ThenConstructReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.then_sequence_urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>Sequence</r:TypeOfObject>"
  puts "        </d:ThenConstructReference>"
      if xmlconstruct.else_children.any?
  puts "        <d:ElseConstructReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.else_sequence_urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>Sequence</r:TypeOfObject>"
  puts "        </d:ElseConstructReference>"
      end
  puts "      </d:IfThenElse>"
 
  puts "      <d:Sequence>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.then_sequence_urn_id}:#{@instance.version}</r:URN>"
  safeputs "        <d:ConstructName><r:String xml:lang=\"en-GB\">then_seq_#{xmlconstruct.construct.textid}</r:String></d:ConstructName>"
  puts "        <r:Label>"
  safeputs "    	  <r:Content xml:lang=\"en-GB\">then_seq_#{xmlconstruct.construct.textid}</r:Content>"
  puts "        </r:Label>"
      xmlconstruct.if_children.each do |cc_child|
  puts "    	<d:ControlConstructReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{cc_child.construct.urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>#{cc_child.type_of_object}</r:TypeOfObject>"
  puts "        </d:ControlConstructReference>"
      end
  puts "      </d:Sequence>"
  
      if xmlconstruct.else_children.any?
  puts "      <d:Sequence>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{xmlconstruct.construct.else_sequence_urn_id}:#{@instance.version}</r:URN>"
  safeputs "        <d:ConstructName><r:String xml:lang=\"en-GB\">else_seq_#{xmlconstruct.construct.textid}</r:String></d:ConstructName>"
  puts "        <r:Label>"
  safeputs "    	  <r:Content xml:lang=\"en-GB\">else_seq_#{xmlconstruct.construct.textid}</r:Content>"
  puts "        </r:Label>"
        xmlconstruct.else_children.each do |cc_child|
  puts "        <d:ControlConstructReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{cc_child.construct.urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>#{cc_child.type_of_object}</r:TypeOfObject>"
  puts "        </d:ControlConstructReference>"
        end
  puts "      </d:Sequence>"
      end

      xmlconstruct.children.each do |cc_child|
        puts_control_construct(cc_child)
      end
    end
  end
  
  #the text and the code are swapped for the launch version
  def puts_if_condition(condition)
    re = /(.*)\s?\[(.*)\]\s*\Z/
    cond = CGI.escapeHTML(condition)
    match1 = cond.match re
    if match1
      condText = match1[1].strip
      condCode = match1[2].strip
    else
      condText = cond.strip
      condCode = ""
    end  
  puts "        <d:IfCondition>"
  puts "          <r:Description>"
  puts "            <r:Content xml:lang=\"en-GB\">#{condCode}</r:Content>"
  puts "          </r:Description>"
  puts "          <r:Command>"
  puts "            <r:ProgramLanguage>pseudo-code</r:ProgramLanguage>"
  puts "            <r:CommandContent>#{condText}</r:CommandContent>"
  puts "          </r:Command>"
  puts "        </d:IfCondition>"
  end
end
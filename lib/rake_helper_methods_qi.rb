module PutsQuestionItems

  def puts_question_items(question_items)
  puts "    <d:QuestionScheme versionDate=\"#{@date_stamp}\">"
  puts "      <r:URN>urn:ddi:#{@instance.agency}:#{@instance.question_item_scheme_urn_id}:#{@instance.version}</r:URN>"
  puts "      <d:QuestionSchemeName><r:String xml:lang=\"en-GB\">#{@instance.question_scheme}</r:String></d:QuestionSchemeName>"

    question_items.each do |question_item|
  puts "      <d:QuestionItem>"
  puts "        <r:URN>urn:ddi:#{@instance.agency}:#{question_item.urn_id}:#{@instance.version}</r:URN>"
  puts "        <r:UserAttributePair>"
  puts "          <r:AttributeKey>extension:Label</r:AttributeKey>"
  puts "          <r:AttributeValue>{\"en-GB\":\"#{question_item.label}\"}</r:AttributeValue>"
  puts "        </r:UserAttributePair>"
  puts "        <d:QuestionItemName><r:String xml:lang=\"en-GB\">#{question_item.textid}</r:String></d:QuestionItemName>"
  puts "        <d:QuestionText audienceLanguage=\"en-GB\">"
  puts "    	  <d:LiteralText>"
  puts "    	    <d:Text>#{question_item.literal}</d:Text>"
  puts "    	  </d:LiteralText>"
  puts "        </d:QuestionText>"

      if question_item.response_domain_alls
        if question_item.response_domain_alls.count > 1
  puts "        <d:StructuredMixedResponseDomain>"
          question_item.response_domain_alls.each do |rda|
  puts "    	  <d:ResponseDomainInMixed>"
          if rda.response_domain_type.id == 1
            texts_inline(rda.domain)
          elsif rda.response_domain_type.id == 2
            numerics_inline(rda.domain)
          elsif rda.response_domain_type.id == 3
            codes_reference(rda.domain.code_scheme)
          elsif rda.response_domain_type.id == 4
            datetimes_inline(rda.domain)
          end
  puts "    	  </d:ResponseDomainInMixed>"
        end
  puts "        </d:StructuredMixedResponseDomain>"
        else
          question_item.response_domain_alls.each do |rda|
            if rda.response_domain_type.id == 1
              texts_inline(rda.domain)
            elsif rda.response_domain_type.id == 2
              numerics_inline(rda.domain)
            elsif rda.response_domain_type.id == 3
              codes_reference(rda.domain.code_scheme)
            elsif rda.response_domain_type.id == 4
              datetimes_inline(rda.domain)
            end
          end
        end
      end
      if question_item.instruction
  puts "        <d:InterviewerInstructionReference>"
  puts "          <r:URN>urn:ddi:#{@instance.agency}:#{question_item.instruction.urn_id}:#{@instance.version}</r:URN>"
  puts "          <r:TypeOfObject>Instruction</r:TypeOfObject>"
  puts "        </d:InterviewerInstructionReference>"
      end
  puts "      </d:QuestionItem>"
    end
  puts "    </d:QuestionScheme>"
  end
end

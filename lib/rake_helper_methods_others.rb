module PutsOthers
  
  def texts_inline(rdtext)
    if rdtext.maxlen.present?
  puts "            <d:TextDomain maxLength=\"#{rdtext.maxlen}\">"
    else
  puts "            <d:TextDomain>"
    end
  puts "              <r:Label>"
  puts "                <r:Content xml:lang=\"en-GB\">#{rdtext.label}</r:Content>"
  puts "              </r:Label>"
  puts "            </d:TextDomain>"
  end

  def numerics_inline(rdnum)
  puts "            <d:NumericDomain>"
  puts "              <r:NumberRange>"
    if rdnum.min.present?
  puts "                <r:Low>#{rdnum.min}</r:Low>"
    end
    if rdnum.max.present?
  puts "                <r:High>#{rdnum.max}</r:High>"
    end
  puts "              </r:NumberRange>"
  puts "              <r:NumericTypeCode>#{rdnum.numeric_type.label}</r:NumericTypeCode>"
  puts "              <r:Label>"
  puts "                <r:Content xml:lang=\"en-GB\">#{rdnum.label}</r:Content>"
  puts "              </r:Label>"
  puts "            </d:NumericDomain>"
  end
  
   def codes_reference(rdcode)
  puts "            <d:CodeDomain>"
  puts "              <r:CodeListReference>"
  puts "                <r:URN>urn:ddi:#{@instance.agency}:#{rdcode.urn_id}:#{@instance.version}</r:URN>"
  puts "                <r:TypeOfObject>CodeList</r:TypeOfObject>"
  puts "              </r:CodeListReference>"
  puts "            </d:CodeDomain>"
  end

  def datetimes_inline(rddt)
  puts "            <d:DateTimeDomain>"
  puts "              <r:DateFieldFormat>#{rddt.format}</r:DateFieldFormat>"
  puts "              <r:DateTypeCode>#{rddt.datetime_type.label}</r:DateTypeCode>"
  puts "              <r:Label>"
  puts "                <r:Content xml:lang=\"en-GB\">#{rddt.label}</r:Content>"
  puts "              </r:Label>"
  puts "            </d:DateTimeDomain>"
  end

end

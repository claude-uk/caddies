module InstancesHelper
  def write_segment(node)
    #used recursively
    html = "<li>\n"
    #is the id in ccall
    node_id = node.id
    node_class = node.construct_type
    
    #type for list nestings
    if ['CcQuestion', 'CcStatement'].include? node_class
      node_type = "file"
    else
      node_type = "folder"
    end


    #main nodetext
    if ['CcQuestion', 'CcSequence'].include? node_class    
      node_text = node.construct.textid
    elsif (node_class == "CcIfthenelse")
      if node.construct.condition.empty?
        node_text = "<span class=\"error\">...missing condition...</span>"
      else
        node_text = node.construct.condition
      end
    elsif (node_class == "CcLoop")
      node_text = 'Loop '
      first = 0
      if (node.construct.loop_variable.present?) and ((node.construct.initial_value.present?) and (node.construct.end_value.present?))
        node_text += 'from ' + node.construct.loop_variable + ' = ' + node.construct.initial_value.to_s() + ' to ' + node.construct.end_value.to_s()
        first = 1
      end
      if (node.construct.loop_while.present?)
        if first == 1
          node_text += ' and '
        end
        node_text += 'while ' + node.construct.loop_while
      end        
    elsif (node_class == "CcStatement")
      if node.construct.statement_item.empty?
        node_text = "<span class=\"error\">...empty statement...</span>"
      else
        node_text = node.construct.statement_item
      end
    end
    html << "<span class=\"#{node_class}\">#{node_text}</span>\n"
    

    #node content, ie for questions
    if (node_class == "CcQuestion")
      html << "<span class=\"question_content\">#{node.construct.question_reference.literal}</span>\n"
      if (node.construct.question_reference_type == 'QuestionItem')
      	html << '<ul>'
				node.construct.question_reference.response_domain_alls.each do |rda|
					if rda.domain_type == 'ResponseDomainText'
						html << "<li class=\"answer\">Text</li>"
					elsif rda.domain_type == 'ResponseDomainNumeric'
						#if rda.domain.label.present?
						#  numeric = rda.domain.label
						if rda.domain.numeric_type.label.present?
							numeric = rda.domain.numeric_type.label          
						else
							numeric = 'Numeric'
						end
						if rda.domain.min.present?
							from = rda.domain.min         
						else
							from = '~'
						end
						if rda.domain.max.present?
							to = rda.domain.max          
						else
							to = '~'
						end
						html << "<li class=\"answer\">#{numeric} (#{from} to #{to})</li>"
					elsif rda.domain_type == 'ResponseDomainDatetime'
						if rda.domain.datetime_type.label.present?
							datetime = rda.domain.datetime_type.label          
						else
							datetime = 'Datetime'
						end
						html << "<li class=\"answer\">#{datetime}</li>"
					elsif rda.domain_type == 'ResponseDomainCode'
						#html << "<li class=\"answer\">Code</li>"
						html << "<li class=\"codeanswer\"><ul class=\"codes\">\n"
						rda.domain.code_scheme.codes.each do |code|
							html << "<li class=\"code\"><span class=\"cs_value\">#{code.cs_value}</span> #{code.category.label}</li>\n"
						end
						html << "</li></ul>"
					end
				end
				html << '</ul>'

      elsif (node.construct.question_reference_type == 'QuestionGrid')
				#html << "<ul><li class=\"grid\"></li></ul>"
				html << "<li>"
				html << "<table class=docgrid>\n"
				html << "  <tr>"
				html << "	<th>"
			  if node.construct.question_reference.corner_label == 'Vertical' and node.construct.question_reference.vertical_codelist.present?
				  html << node.construct.question_reference.vertical_codelist.label
				elsif node.construct.question_reference.corner_label == 'Horizontal'
	    	  html << node.construct.question_reference.horizontal_codelist.label
				end
				html << "	</th>"

				node.construct.question_reference.horizontal_codelist.codes.each do |code|
				  html << "    	<th>#{code.category.label}</th>"
				end
				html << "  </tr>\n"

#				#dummy for testing rd display
#				if node.construct.question_reference.id == 6
#				  html << "<tr class=responsedomains>\n"
#				  html << "<td></td>"
#				  html << "<td>Integer</td>"
#				  html << "<td>Integer</td>"
#				  html << "<td class=\"code\"><b>Y</b>-Male</br><b>X</b>-Female</td>"
#				  html << "<td>Integer</td>"
#				  html << "<td>Integer</td>"
#				  html << "<td class=\"code\"><b>0</b>-Domicilliary</br><b>1</b>-Institutional(Including nursing homes)</td>"
#				  html << "<td class=\"code\"><b>2</b>-Alive now</br><b>3</b>-Died 28 days or later</br><b>4</b>-Died 7-27 days inclusive</br><b>5</b>-Died under 7 days</br><b>6</b>-Stillborn</br><b>7</b>-Miscarriage</br><b>8</b>-Ectopic Pregnancy</td>"
#				  html << "<td class=\"code\"><b>Y</b>-Toxaemia</br><b>X</b>-A.P.H.</br><b>0</b>-Other complications</br><b>1</b>-No complications at all</br><b>2</b>-Not known whether any complications or not</td>"
#				  html << "<td class=\"code\"><b>3</b>-Spontaneous</br><b>4</b>-Forceps</br><b>5</b>-Caesarean</br><b>6</b>-Others</br><b>7</b>-Method not known</td>"
#				  html << "</tr>\n"
#				end
#				#end of dummy
				
				html << "<tr class=responsedomains>\n"
				html << "<td></td>\n"
				node.construct.question_reference.columns.each do |column|
					if column.response_domain_all.present?
						if column.response_domain_all.domain_type != "ResponseDomainCode"
							html << "<td>#{column.response_domain_all.specific_type}</td>\n"
						else
							html << "<td class=\"gridcode\"><ul>"
							column.response_domain_all.domain.code_scheme.codes.each do |code|
								html << "<li class=\"gridcode\"><span class=\"value\">#{code.cs_value}</span>-#{code.category.label}</li>"
							end
							html << "</ul></td>\n"
						end
					else
						html << "<td></td>\n"
					end
				end
				html << "</tr>\n"

				if !node.construct.question_reference.vertical_codelist.nil?
	  			node.construct.question_reference.vertical_codelist.codes.each do |code|
						html << "<tr>"
			  		html << "<td>#{code.category.label}</td>"
			  		node.construct.question_reference.horizontal_codelist.codes.each do
							html << "<td class=\"answer\">&nbsp;</td>"
			  		end
						html << "</tr>"
	  			end
  			end
  			for i in 1..node.construct.question_reference.vertical_roster_rows
    			html << "<tr>"
					if i == 1 and node.construct.question_reference.vertical_roster_label.present?
		  			html << "<td class=\"rosterlabel\">#{node.construct.question_reference.vertical_roster_label}</td>"
					else
		  			html << "<td>&nbsp;</td>"
					end
					node.construct.question_reference.horizontal_codelist.codes.each do
		  			html << "<td class=\"answer\">&nbsp;</td>"
					end
    			html << "</tr>"
    		end	
				html << "</table>"
				html << "</li>"
			else
				html << "<ul></ul>"
      end		#end of if q ref type
    end
    
    
    if (node_type == "folder")
      html << "<ul id=\"children\">\n"
    end

    if (node_class == "CcSequence")
      #if node.construct.cc_alls.empty?
      if node.children.empty?
        html << "<span class=\"error\">...empty sequence...</span>\n"      
      else
        node.children.includes(:construct).each{|child_node|
          html << write_segment(child_node)
        }
      end
    elsif (node_class == "CcLoop")
      if node.children.empty?
        html << "<span class=\"error\">...empty loop...</span>\n"
      else
        node.children.includes(:construct).each{|child_node|
          html << write_segment(child_node)
        }
      end
    elsif (node_class == "CcIfthenelse")
      ifchildren = node.if_children
      elsechildren = node.else_children
      html << write_branch('if', ifchildren)
      html << write_branch('else', elsechildren)
 
    end

    if (node_type == "folder")
      html << "</ul>\n"
    end

    html << "</li>\n"
  end

  def write_branch(branch, branch_children)
    html = "<li>\n"
    html << "<span class=\"branch\">"    
    if branch == 'if'
      html << 'if-true branch: '
    else	#else branch
      html << 'else branch: '
    end
    html << "</span>\n"
    html << "<ul id=\"children\">\n"
    if branch_children.empty?
      html << "<span class=\"error\">...empty branch...</span>\n"
    else
      branch_children.includes(:construct).each{|child_node|
        html << write_segment(child_node)
      }
    end
    html << "</ul>\n"	#end of children
    html << "</li>\n"	#end of branch
  end
end

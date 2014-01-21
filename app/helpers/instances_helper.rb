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
						html << "<li class=\"answer\">#{numeric}</li>"
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
							html << "<li class=\"code\">#{code.category.label}</li>\n"
						end
						html << "</li></ul>"
					end
				end
				html << '</ul>'
			else
				html << "<ul><li class=\"grid\"></li></ul>"
      end
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

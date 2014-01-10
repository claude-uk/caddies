module CcAllsHelper
  def display_segment(node)
    #used recursively
    html = "<li>\n"
    #is the id in ccall
    node_id = node.id
    node_class = node.construct_type
    
    if ['CcQuestion', 'CcStatement'].include? node_class
      node_type = "file"
    else
      node_type = "folder"
    end
    
    node_name = node.construct.textid

    html << "<span class=\"#{node_type}\">#{node_id} "    
    if (node_class == 'CcQuestion')
      html << '<font color="red" size=-1><em>question: </em></font>'
      html << link_to("#{node_name}", cc_question_path(node.construct))
    elsif (node_class == 'CcStatement')
      html <<'<font color="#808080" size=-1><em>statement: </em></font>'
      html << link_to("#{node_name}", cc_statement_path(node.construct))
    elsif (node_class == 'CcSequence')
      html << '<font color="#800000" size=-1><em>sequence: </em></font>'
      html << link_to("#{node_name}", cc_sequence_path(node.construct))
    elsif (node_class == 'CcIfthenelse')
      html << '<font color="#347235" size=-1><em>condition: </em></font>'
      html << link_to("#{node_name}", cc_ifthenelse_path(node.construct))
    elsif (node_class == 'CcLoop')
      html << '<font color="#408080" size=-1><em>loop: </em></font>'
      html << link_to("#{node_name}", cc_loop_path(node.construct))
    else
      html << "(#{node_class}) #{node_name}"
    end
    html << "</span>\n"
    
    if (node_type == "folder")
      html << "<ul id=\"children\">\n"
    end

    if (node_class == "CcSequence")
      #if node.construct.cc_alls.empty?
      if node.children.empty?
        html << '<font color="#FF9900" size=-1><em>...empty sequence...</em></font>'      
      else
        node.children.includes(:construct).each{|child_node|
          html << display_segment(child_node)
        }
      end
    elsif (node_class == "CcLoop")
      if node.children.empty?
        html << '<font color="#FF9900" size=-1><em>...empty loop...</em></font>'
      else
        node.children.includes(:construct).each{|child_node|
          html << display_segment(child_node)
        }
      end
    elsif (node_class == "CcIfthenelse")
      ifchildren = node.if_children
      elsechildren = node.else_children
      html << display_branch('if', ifchildren)
      html << display_branch('else', elsechildren)
 
    end

    if (node_type == "folder")
      html << "</ul>\n"
    end

    html << "</li>\n"
  end

  def display_branch(branch, branch_children)
    html = "<li>\n"
    html << "<span class=\"folder\">- "    
    if branch == 'if'
      html << '<font color="#347235" size=-1><em>if branch: </em></font>'
    else	#else branch
      html << '<font color="#347235" size=-1><em>else branch: </em></font>'
    end
    html << "</span>\n"
    html << "<ul id=\"children\">\n"
    if branch_children.empty?
      html << '<font color="#FF9900" size=-1><em>...empty branch...</em></font>'
    else
      branch_children.includes(:construct).each{|child_node|
        html << display_segment(child_node)
      }
    end
    html << "</ul>\n"	#end of children
    html << "</li>\n"	#end of branch
  end

end

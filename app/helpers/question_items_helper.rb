module QuestionItemsHelper

  def link_to_add_fields(name, f)
    new_qi_rda = QiRda.new
    fields = f.fields_for(:qi_rda, new_qi_rda, :child_index => "new_qi_rda") do |builder|
      render("qi_rda_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"qi_rda\", \"#{escape_javascript(fields)}\")"))
  end

end

class NoSpacesValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if value.match(/\s/)
      object.errors[attribute] << (options[:message] || "can't include spaces")
    end
  end
  

end


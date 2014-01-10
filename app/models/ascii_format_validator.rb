class AsciiFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless is_ascii_string(value)
      object.errors[attribute] << (options[:message] || "is not ascii")
    end
  end
  
  private
  
  def is_ascii_string(string)
    string.bytes {
      |b|
      if b > 127 then return false end
      }
      return true
  end

end


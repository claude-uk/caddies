class Instruction < ActiveRecord::Base

  def ii_Vid
    "ii_V" + "#{id}".rjust(5, '0')
  end

  def short_text
    self.instruction_text.truncate(80, :separator => ' ')
  end
  
  def short_text_with_id
    sep = '~'
    "#{id}".rjust(3, sep) + sep + sep + sep + self.instruction_text.truncate(80, :separator => ' ')
  end
end

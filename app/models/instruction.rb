class Instruction < ActiveRecord::Base
  validates :instruction_text, :ascii_format => true
  has_many :question_items
  has_many :question_grids

	include SharedMethods
  @@type_prefix = "ii"
  cattr_reader :type_prefix

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

  def self.all_used_in_top_sequence(used_question_items, used_question_grids)
    auits = []
    Instruction.all.each do |ii|
      if ii.used_in_top_sequence(used_question_items, used_question_grids)
        auits << ii
      end
    end
    return auits
  end
  
  def used_in_top_sequence(used_question_items, used_question_grids)
    question_items.each do |qi|
      if used_question_items.include?(qi)
          return true
      end
    end
    question_grids.each do |qg|
      if used_question_grids.include?(qg)
          return true
      end
    end
  end

end

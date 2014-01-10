class Universe < ActiveRecord::Base
  validates :univ_text, :presence => true, :ascii_format => true
  has_many :cc_question_universes
  has_many :cc_questions, :through => :cc_question_universes

  def id_plus
    id1 = "#{id}".rjust(2, '.')
    id2 = "#{univ_text}".slice(0,100)
    id1 + '...' + id2 
  end
end

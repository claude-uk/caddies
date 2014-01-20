class QuestionGrid < ActiveRecord::Base
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true, :no_spaces => true
  validates :literal, :presence => true, :ascii_format => true
  validates :intent, :ascii_format => true


  #used in question constructs, allow for 4 digit index
  def id_plus
    #sep = '.'
    sep = '~'
    #sep = '&nbsp;'	#gets protected, shows literally
    id1 = "#{id}".rjust(4, sep)
    id2 = "#{textid}"
    id1 + sep*3 + id2
  end
end

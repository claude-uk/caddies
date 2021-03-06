class QuestionItem < ActiveRecord::Base
  #validate :ascii_literal
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true, :no_spaces => true
  validates :literal, :presence => true, :ascii_format => true
  validates :intent, :ascii_format => true
  has_many :qi_rdas, :dependent => :destroy
  accepts_nested_attributes_for :qi_rdas, :allow_destroy => true
  has_many :cc_questions, :as => :question_reference
  has_many :response_domain_alls, :through => :qi_rdas
  belongs_to :instruction
  scoped_search :on => [:literal, :intent]
  #named_scope :in_top_sequence, :conditions => { :used_in_top_sequence => true }

	include SharedMethods
  @@type_prefix = "qi"
  cattr_reader :type_prefix
  
  def ascii_literal
    #not yet in ruby 1.8.7
    #errors.add(:literal, "The text contains non-ascii characters") if !(literal.force_encoding("UTF-8").ascii_only?)
  end

  #used in question constructs, allow for 4 digit index
  def id_plus
    #sep = '.'
    sep = '~'
    #sep = '&nbsp;'	#gets protected, shows literally
    id1 = "#{id}".rjust(4, sep)
    id2 = "#{textid}"
    id1 + sep*3 + id2
  end
  
	#for xml output
  def type_of_object
    "QuestionItem"
  end
  
  def qi_Vid
    "qi_V" + "#{id}".rjust(5, '0')
  end

  def used
    return cc_questions.any?
  end
  
  ##the root ancestor is the id of the top sequence or of the attic ie 1 or 0
  def used_in_top_sequence
    if used
      cc_questions.each do |ccq|
        if ccq.cc_all.root_ancestor > 0
          return true
        end
      end
    end
    return false
  end
  
  def self.all_used_in_top_sequence
    auits = []
    QuestionItem.all.each do |question_item|
      if question_item.used_in_top_sequence
        auits << question_item
      end
    end
    return auits
  end
  
	#does not exist in ddi3.2, but we use it as a user attribute
  def label
    if !self.textid.starts_with?("qi_")
    	return self.textid
    end
    s = self.textid.slice(3..-1)
    parts = s.split("_")
    s = parts[0]
    if parts[1]
    	s += " " + parts[1]
    	if parts[2]
    		s += "(" + parts[2] + ")"
    	end
    end
    return s
  end
end

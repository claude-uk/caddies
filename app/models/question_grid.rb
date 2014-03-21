class QuestionGrid < ActiveRecord::Base
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true, :no_spaces => true
  validates :literal, :presence => true, :ascii_format => true
  validates :intent, :ascii_format => true
  validates_numericality_of :vertical_roster_rows, :only_integer => true, :allow_nil => true
  validates_presence_of :horizontal_codelist_id		#but verticals could be all roster
  has_many :cc_questions, :as => :question_reference
  has_many :columns, :class_name => 'QgridRda', :dependent => :destroy, :include => [:code], :order => 'codes.cs_order ASC'
  accepts_nested_attributes_for :columns, :allow_destroy => true
  #has_many :response_domain_alls, :through => :columns
  belongs_to :vertical_codelist, :class_name => 'CodeScheme'
  belongs_to :horizontal_codelist, :class_name => 'CodeScheme'
  scoped_search :on => [:literal, :intent]


  #used in question constructs, allow for 4 digit index
  def id_plus
    #sep = '.'
    sep = '~'
    #sep = '&nbsp;'	#gets protected, shows literally
    id1 = "#{id}".rjust(4, sep)
    id2 = "#{textid}"
    id1 + sep*3 + id2
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
    QuestionGrid.all.each do |question_grid|
      if question_grid.used_in_top_sequence
        auits << question_grid
      end
    end
    return auits
  end

end

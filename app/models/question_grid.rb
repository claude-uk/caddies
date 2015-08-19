class QuestionGrid < ActiveRecord::Base
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true, :no_spaces => true
  validates :literal, :presence => true, :ascii_format => true
  validates :intent, :ascii_format => true
  validates_numericality_of :vertical_roster_rows, :only_integer => true, :allow_nil => true
  validates_presence_of :horizontal_codelist_id		#but verticals could be all roster
  validates_presence_of :vertical_roster_rows
  has_many :cc_questions, :as => :question_reference
  has_many :columns, :class_name => 'QgridRda', :dependent => :destroy, :include => [:code], :order => 'codes.cs_order ASC'
  accepts_nested_attributes_for :columns, :allow_destroy => true
  #has_many :response_domain_alls, :through => :columns
  belongs_to :vertical_codelist, :class_name => 'CodeScheme'
  belongs_to :horizontal_codelist, :class_name => 'CodeScheme'
  belongs_to :instruction
  scoped_search :on => [:literal, :intent]

	include SharedMethods
  @@type_prefix = "qg"
  cattr_reader :type_prefix


  #used in question constructs, allow for 4 digit index
  def id_plus
    #sep = '.'
    sep = '~'
    #sep = '&nbsp;'	#gets protected, shows literally
    id1 = "#{id}".rjust(4, sep)
    id2 = "#{textid}"
    id1 + sep*3 + id2
  end

  def type_of_object
    "QuestionGrid"
  end
  
  def qi_Vid
    "qg_V" + "#{id}".rjust(5, '0')
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
  
  #count the grids with more than one response domain (for the stats)
  def self.all_with_mixed_rd_count
  	c = 0
    QuestionGrid.all.each do |question_grid|
      if question_grid.response_domain_count > 1
        c += 1
      end
    end
  	return c
  end

  #count the grids with a single response domain (for the stats)
  #add up the surplus response domains
  #add up the surplus code response domains
  def self.all_with_single_rd_count
  	c = 0
  	dup = 0
  	dupcode = 0
    QuestionGrid.all.each do |question_grid|
      if question_grid.response_domain_count == 1
        c += 1
        dup += question_grid.columns.count - 1
        if question_grid.columns[0].response_domain_all.domain_type == 'ResponseDomainCode'
        	dupcode += question_grid.columns.count - 1
       	end
      end
    end
  	return [c, dup, dupcode]
  end
  
  #used in the xml output to determine if a simple response domain is needed
  #return 0 if there are no rdas or all rdas are null, 1 if there is a single non-null rda for all columns, else the count
  def response_domain_count
    if self.columns.any?
      rda_hash = self.columns.group_by(&:response_domain_all_id)
      if rda_hash.count == 1
        if rda_hash.keys[0].nil?
          return 0
        else
          return 1
        end
      else
        return rda_hash.count
      end
      
    else
      return 0
    end
  end

	#does not exist in ddi3.2, but we use it as a user attribute
  def label
    if !self.textid.starts_with?("qg_")
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
  
  #number of rows for the mapper
  #includes the header row (for consistency), the vertical codelist and any roster rows
  def rows
    if self.vertical_codelist
      return 1 + vertical_codelist.size + vertical_roster_rows
    else
      return 1 + vertical_roster_rows
    end
  end

  #number of cols for the mapper
  #includes the header col which may include rosters
  #we haven't allowed rosters horizontally
  def cols
    return 1 + horizontal_codelist.size
  end
end

class CcQuestion < ActiveRecord::Base
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true, :no_spaces => true
  validates_presence_of :question_reference_type, :question_reference_id, :response_unit_id
  belongs_to :question_reference, :polymorphic => true
  belongs_to :response_unit
  has_many :cc_question_universes
  has_many :universes, :through => :cc_question_universes
  has_one :cc_all, :as => :construct, :dependent => :destroy
  accepts_nested_attributes_for :cc_all
  #after_initialize :init

	include SharedMethods
  @@type_prefix = "qc"
  cattr_reader :type_prefix
  
  #no longer needed
  def init
        self.cc_all ||= build_cc_all
  end
  
  def label
    if !self.textid.starts_with?("qc_")
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
  
  def mapper_size
    if self.question_reference_type == 'QuestionItem'
      return '-'
    else	#i.e. QuestionGrid
      dim1 = self.question_reference.rows.to_s
      dim2 = self.question_reference.cols.to_s
      return '[' + dim1 + ',' + dim2 + ']'
    end
  end
end

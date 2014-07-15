class CodeScheme < ActiveRecord::Base
  #is called CodeList in ddi3.2
  validates :label, :presence => true, :ascii_format => true
  validates_presence_of :codes
  has_many :response_domain_codes
  has_many :codes, :order => "cs_order ASC", :dependent => :destroy
  accepts_nested_attributes_for :codes, :allow_destroy => true
  has_many :question_grids_h, :class_name => 'QuestionGrid', :foreign_key => 'horizontal_codelist_id'
  has_many :question_grids_v, :class_name => 'QuestionGrid', :foreign_key => 'vertical_codelist_id'

	include SharedMethods
  @@type_prefix = "co"
  cattr_reader :type_prefix
	
  def label_with_id
    sep = '~'
    t = "#{id}".rjust(2, sep)
    t + sep*3 + "#{label}"
  end

  #used in response domain
  def used
    return response_domain_codes.any?
  end
  
  ##nb:loop from the cs instead of the qi to avoid uniqueness issues
  ##used in response domain
  ##take account of the codelist in the grid headers
  def self.all_used_in_top_sequence(question_items, question_grids)
    auits = []
    CodeScheme.all.each do |cs|
      if cs.used_in_top_sequence(question_items, question_grids)
        auits << cs
      end
    end
    return auits
  end
  
  def used_in_top_sequence(question_items, question_grids)
    response_domain_codes.each do |rdc|
      rdc.response_domain_all.question_items.each do |qi|
        if question_items.include?(qi)
          return true
        end
      end
      rdc.response_domain_all.question_grids.each do |qg|
        if question_grids.include?(qg)
          return true
        end
      end      
    end
    #return used_in_question_grids
    question_grids_h.each do |qgh|
    	if question_grids.include?(qgh)
          return true
      end
    end
    question_grids_v.each do |qgv|
    	if question_grids.include?(qgv)
          return true
      end
    end
    return false
  end

	#used in question grid frames
  def used_in_question_grids
    return question_grids_h.any? || question_grids_v.any?
  end
  
  def reset_question_grids
		self.question_grids_h.each do |qgrid|
		  #clear old columns
			qgrid.columns.destroy_all()
			#add new ones
			self.codes.each do |code|
				qgrid.columns.create(:code_id => code.id)
			end
		end
  end

end

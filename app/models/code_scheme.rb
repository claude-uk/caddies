class CodeScheme < ActiveRecord::Base
  validates :label, :presence => true, :ascii_format => true
  validates_presence_of :codes
  has_many :response_domain_codes
  has_many :codes, :order => "cs_order ASC", :dependent => :destroy
  accepts_nested_attributes_for :codes, :allow_destroy => true
	
  def label_with_id
    sep = '~'
    t = "#{id}".rjust(2, sep)
    t + sep*3 + "#{label}"
  end

  def used
    return response_domain_codes.any?
  end
  
  ##nb:loop from the cs instead of the qi to avoid uniqueness issues
  def self.all_used_in_top_sequence(question_items)
    auits = []
    CodeScheme.all.each do |cs|
      if cs.used_in_top_sequence(question_items)
        auits << cs
      end
    end
    return auits
  end
  
  def used_in_top_sequence(question_items)
    response_domain_codes.each do |rdc|
      rdc.response_domain_all.question_items.each do |qi|
        if question_items.include?(qi)
          return true
        end
      end
    end
    return false
  end

end

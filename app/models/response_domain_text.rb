class ResponseDomainText < ActiveRecord::Base
  validates :label, :presence => true, :ascii_format => true
  validates_numericality_of :maxlen, :only_integer => true, :allow_nil => true
  has_one :response_domain_all, :as => :domain, :dependent => :destroy
  #after_initialize :init
  accepts_nested_attributes_for :response_domain_all

	include SharedMethods
  @@type_prefix = "mt"
  cattr_reader :type_prefix

  #used in create action
  def init
        self.response_domain_all ||= build_response_domain_all
        self.response_domain_all.response_domain_type_id ||= ResponseDomainType.find_by_label('text').id
  end

  def used
    return response_domain_all.question_items.any?
  end

  def self.all_used_in_top_sequence(used_question_items, used_question_grids)
    auits = []
    ResponseDomainText.all.each do |rd|
      if rd.used_in_top_sequence(used_question_items, used_question_grids)
        auits << rd
      end
    end
    return auits
  end
  
  def used_in_top_sequence(used_question_items, used_question_grids)
    response_domain_all.question_items.each do |qi|
      if used_question_items.include?(qi)
          return true
      end
    end
    response_domain_all.question_grids.each do |qg|
      if used_question_grids.include?(qg)
          return true
      end
    end
  end

end

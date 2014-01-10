class ResponseDomainText < ActiveRecord::Base
  validates :label, :presence => true, :ascii_format => true
  validates_numericality_of :maxlen, :only_integer => true, :allow_nil => true
  has_one :response_domain_all, :as => :domain, :dependent => :destroy
  #after_initialize :init
  accepts_nested_attributes_for :response_domain_all

  #used in create action
  def init
        self.response_domain_all ||= build_response_domain_all
        self.response_domain_all.response_domain_type_id ||= ResponseDomainType.find_by_label('text').id
  end

  def used
    return response_domain_all.question_items.any?
  end
end

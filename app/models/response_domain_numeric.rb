class ResponseDomainNumeric < ActiveRecord::Base
  validates :label, :presence => true, :ascii_format => true
  validates :numeric_type, :presence => true
  validates_numericality_of :min, :only_integer => true, :allow_nil => true
  validates_numericality_of :max, :only_integer => true, :allow_nil => true
  belongs_to :numeric_type
  has_one :response_domain_all, :as => :domain, :dependent => :destroy
  #after_initialize :init

  #used in create action
  def init
        self.response_domain_all ||= build_response_domain_all
        self.response_domain_all.response_domain_type_id ||= ResponseDomainType.find_by_label('numeric').id
  end

  def used
    return response_domain_all.question_items.any?
  end
end

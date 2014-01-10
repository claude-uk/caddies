class ResponseDomainDatetime < ActiveRecord::Base
  validates :label, :presence => true, :ascii_format => true
  belongs_to :datetime_type
  has_one :response_domain_all, :as => :domain, :as => :domain, :dependent => :destroy
  #after_initialize :init

  #used in create action
  def init
        self.response_domain_all ||= build_response_domain_all
        self.response_domain_all.response_domain_type_id ||= ResponseDomainType.find_by_label('datetime').id
  end

  def used
    return response_domain_all.question_items.any?
  end
end

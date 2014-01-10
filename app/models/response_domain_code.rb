class ResponseDomainCode < ActiveRecord::Base
  belongs_to :code_scheme
  has_one :response_domain_all, :as => :domain, :dependent => :destroy
  validates_presence_of :code_scheme_id
  #after_initialize :init

  #used in create action
  def init
        self.response_domain_all ||= build_response_domain_all
        self.response_domain_all.response_domain_type_id ||= ResponseDomainType.find_by_label('code').id
  end

  def used
    return response_domain_all.question_items.any?
  end
end

class QiRda < ActiveRecord::Base
  belongs_to :question_item
  belongs_to :response_domain_all
  accepts_nested_attributes_for :response_domain_all
end

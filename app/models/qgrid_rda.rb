class QgridRda < ActiveRecord::Base
  belongs_to :question_grid
  belongs_to :code
  belongs_to :response_domain_all
end

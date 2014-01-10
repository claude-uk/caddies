class CcQuestionUniverse < ActiveRecord::Base
  belongs_to :cc_question
  belongs_to :universe
end

class ResponseUnit < ActiveRecord::Base
  validates :text, :presence => true, :ascii_format => true
  has_many :cc_questions
end

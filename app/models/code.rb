class Code < ActiveRecord::Base
  #validates :cs_value, :presence => true, :ascii_format => true, :no_spaces => true
  #validates_presence_of :category_id
  belongs_to :code_scheme
  belongs_to :category
  
end

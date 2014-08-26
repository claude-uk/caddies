class Code < ActiveRecord::Base
	#the validations were commented out, can't remember why, maybe for grid frames?
  #validates :cs_value, :presence => true, :ascii_format => true, :no_spaces => true
  #validates_presence_of :category_id
  belongs_to :code_scheme
  belongs_to :category
  
end

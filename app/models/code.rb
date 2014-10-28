class Code < ActiveRecord::Base
	#the validations were commented out, can't remember why, maybe for grid frames?
	#they are back in to comply with ddi3.2
  validates :cs_value, :presence => true, :ascii_format => true, :no_spaces => true
  validates_presence_of :category_id
  belongs_to :code_scheme
  belongs_to :category
  
	include SharedMethods
  @@type_prefix = "co"
  cattr_reader :type_prefix
  
end

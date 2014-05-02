class CcStatement < ActiveRecord::Base
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true, :no_spaces => true
  validates :statement_item, :presence => true, :ascii_format => true
  has_one :cc_all, :as => :construct, :dependent => :destroy
  accepts_nested_attributes_for :cc_all
  #after_initialize :init

	include SharedMethods
  @@type_prefix = "si"
  cattr_reader :type_prefix
  
  #no longer needed
  def init
        self.cc_all ||= build_cc_all
  end

end

class CcIfthenelse < ActiveRecord::Base
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true, :no_spaces => true
  validates :condition, :presence => true, :ascii_format => true
  has_one :cc_all, :as => :construct
  accepts_nested_attributes_for :cc_all
  #after_initialize :init

	include SharedMethods
  @@type_prefix = "if"
  cattr_reader :type_prefix
	include IfThenElseMethods
  @@seth_prefix = "seth"
  cattr_reader :seth_prefix
  @@seel_prefix = "seel"
  cattr_reader :seel_prefix
  
  #no longer needed
  def init
        self.cc_all ||= build_cc_all
  end
end

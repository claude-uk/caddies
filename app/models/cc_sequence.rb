class CcSequence < ActiveRecord::Base
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true
  has_one :cc_all, :as => :construct, :dependent => :destroy
  accepts_nested_attributes_for :cc_all
  #after_initialize :init

	include SharedMethods
  @@type_prefix = "se"
  cattr_reader :type_prefix
  
  #no longer needed
  def init
        self.cc_all ||= build_cc_all
  end
  
  def label
  	if self.textid == 'TopSequence'
  		return "Start of " + Instance.first.prefix
  	else
  		return self.textid
  	end
  end
end

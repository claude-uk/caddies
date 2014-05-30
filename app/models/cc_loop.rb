class CcLoop < ActiveRecord::Base
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true, :no_spaces => true
  validates_numericality_of :initial_value, :only_integer => true, :allow_nil => true
  validates_numericality_of :end_value, :only_integer => true, :allow_nil => true
  validate :conditions
  has_one :cc_all, :as => :construct, :dependent => :destroy
  accepts_nested_attributes_for :cc_all
  #after_initialize :init

	include SharedMethods
  @@type_prefix = "lp"
  cattr_reader :type_prefix
  @@selp_prefix = "selp"
  cattr_reader :selp_prefix
  
  #no longer needed
  def init
        self.cc_all ||= build_cc_all
  end
  
  def conditions
    if !self.loop_while_exists and !self.end_value
      errors[:base] << ("You must enter an end value or a loop_while condition.")
    end
  end

  #the empty string is not false in ruby
  def xml_loop_variable
    if self.loop_variable and (self.loop_variable != '')
      self.loop_variable
    else
      'i'
    end
  end
  
  def loop_while_exists
    if self.loop_while and (self.loop_while != '')
      return true
    else
      return false
    end
  end

  #our ddi3 xml output requires some transformations
  #In the same way as Colectica I include the loop var in the init code instead of managing a var reference
  def xml_initial_value
    if self.initial_value
      xiv = self.xml_loop_variable
      xiv += ' = '
      xiv += self.initial_value.to_s
    end
  end
  
  def xml_loop_while
    xlw = ''
    if (self.loop_while_exists and self.end_value)
      xlw += '('
    end
    if self.loop_while_exists
      xlw +=  self.loop_while
    end
    if (self.loop_while_exists and self.end_value)
      xlw += ') AND ('
    end
    if self.end_value
      xlw += self.xml_loop_variable
      xlw += ' < ' + (self.end_value + 1).to_s
    end
    if (self.loop_while_exists and self.end_value)
      xlw += ')'
    end
    return xlw
  end
end

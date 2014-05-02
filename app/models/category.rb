class Category < ActiveRecord::Base
  validates :label, :presence => true, :ascii_format => true
  has_many :codes
  belongs_to :instance
  scoped_search :on => [:label]

	include SharedMethods
  @@type_prefix = "ca"
  cattr_reader :type_prefix

  def instance_id
    1
  end
  
  def label_with_id
    t = "#{id}".rjust(3, '.')
    t + '...' + "#{label}"
  end

  def label_plus_id
    #t = ""
    t = "#{label}".truncate(80, :omission => '')
    t = t.ljust(80, '.')
    t = t + "#{id}".rjust(4, '.')
    #t =t.gsub(' ', '&nbsp;')
    #t = '<pre>' + t + '</pre>'
    #t.html_safe
  end
  
  def used
    return codes.any?
  end

  ##nb:loop from the categories instead of the code schemes to avoid uniqueness issues
  def self.all_used_in_top_sequence(code_schemes)
    auits = []
    Category.all.each do |c|
      if c.used_in_top_sequence(code_schemes)
        auits << c
      end
    end
    return auits
  end
  
  def used_in_top_sequence(code_schemes)
    codes.each do |cc|
      if code_schemes.include?(cc.code_scheme)
        return true
      end
    end
    return false
  end

end

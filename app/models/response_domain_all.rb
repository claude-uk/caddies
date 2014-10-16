class ResponseDomainAll < ActiveRecord::Base
  belongs_to :domain, :polymorphic => true
  belongs_to :response_domain_type
  #has_many :question_items
  has_many :qi_rdas
  has_many :question_items, :through => :qi_rdas
  has_many :qgrid_rdas
  has_many :question_grids, :through => :qgrid_rdas
  
  #allow for 4 digit index
  def id_plus
    id1 = "#{id}".rjust(4, '.')
    type = response_domain_type.label
    type2 = type.ljust(9, '.')    
    id2 = "#{domain_id}".rjust(2, '.')
    id1 + '...' + type2 + id2 + '...' + anylabel
  end

  #allow for 4 digit index
  def id_plus2
  sep = '~'
    id1 = "#{id}".rjust(4, sep)
    type = response_domain_type.label
    type2 = type.ljust(9, sep)    
    id2 = "#{domain_id}".rjust(3, sep)
    id1 + sep + sep + sep + type2 + id2 + sep + sep + sep + anylabel
  end

  #simplfied version
  def id_plus3
  sep = '~'
    type = response_domain_type.label
    type2 = type.ljust(9, sep)    
    id2 = "#{domain_id}".rjust(3, sep)
    type2 + id2 + sep + sep + sep + anylabel
  end

  def anylabel
    type = response_domain_type.label
    if type == "text"
      rd_label = domain.label || "text"
    elsif type == "numeric"
      rd_label = domain.label || "numeric"
    elsif type == "datetime"
      rd_label = domain.label || "datetime"
    elsif type == "code"
      rd_label = domain.code_scheme.label || "code"
    end
  end

  def specific_type
    type = response_domain_type.label
    if type == "text"
      stype = "text"
    elsif type == "code"
      stype = "code"
    elsif type == "numeric"
      stype = domain.numeric_type.label
    elsif type == "datetime"
      stype = domain.datetime_type.label
    end
  end
end

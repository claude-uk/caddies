class EditResponseDomainAlls < ActiveRecord::Migration
  def self.up
    change_table :response_domain_alls do |t|
      t.rename :response_domain_idx, :domain_id
      t.string :domain_type
      execute("update response_domain_alls set domain_type = (select 'ResponseDomain' || upper(substr(rdt.label,1,1)) || substr(rdt.label,2) from response_domain_types as rdt where rdt.id = response_domain_alls.response_domain_type_id)")
    end
  end

  def self.down
    change_table :response_domain_alls do |t|
      t.remove :domain_type
      t.rename :domain_id, :response_domain_idx
    end
  end
end

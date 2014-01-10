class CreateResponseDomainAlls < ActiveRecord::Migration
  def self.up
    create_table :response_domain_alls do |t|
      t.references :response_domain_type
      t.integer :response_domain_idx

      t.timestamps
    end
  end

  def self.down
    drop_table :response_domain_alls
  end
end

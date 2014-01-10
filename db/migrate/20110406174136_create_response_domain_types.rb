class CreateResponseDomainTypes < ActiveRecord::Migration
  def self.up
    create_table :response_domain_types do |t|
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :response_domain_types
  end
end

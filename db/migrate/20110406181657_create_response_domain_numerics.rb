class CreateResponseDomainNumerics < ActiveRecord::Migration
  def self.up
    create_table :response_domain_numerics do |t|
      t.references :numeric_type
      t.integer :min
      t.integer :max
      t.references :code_scheme

      t.timestamps
    end
  end

  def self.down
    drop_table :response_domain_numerics
  end
end

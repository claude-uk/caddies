class EditResponseDomainNumeric < ActiveRecord::Migration
  def self.up
    change_table :response_domain_numerics do |t|
      t.remove :code_scheme_id
      t.column :label, :string
    end
  end

  def self.down
    change_table :response_domain_numerics do |t|
      t.remove :label
      t.references :code_scheme
    end
  end
end

class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.references :code_scheme
      t.references :category
      t.integer :cs_value
      t.integer :cs_order

      t.timestamps
    end
  end

  def self.down
    drop_table :codes
  end
end

class CreateCodeSchemes < ActiveRecord::Migration
  def self.up
    create_table :code_schemes do |t|
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :code_schemes
  end
end

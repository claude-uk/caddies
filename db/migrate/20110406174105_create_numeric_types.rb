class CreateNumericTypes < ActiveRecord::Migration
  def self.up
    create_table :numeric_types do |t|
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :numeric_types
  end
end

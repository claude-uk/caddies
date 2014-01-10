class CreateDatetimeTypes < ActiveRecord::Migration
  def self.up
    create_table :datetime_types do |t|
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :datetime_types
  end
end

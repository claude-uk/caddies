class DropCcTypes < ActiveRecord::Migration
  def self.up
    drop_table :cc_types
  end

  def self.down
    create_table :cc_types do |t|
      t.string :label

      t.timestamps
    end
  end
end

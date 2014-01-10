class CreateCcTypes < ActiveRecord::Migration
  def self.up
    create_table :cc_types do |t|
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :cc_types
  end
end

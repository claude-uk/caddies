class CreateSequenceItems < ActiveRecord::Migration
  def self.up
    create_table :sequence_items do |t|
      t.string :textid
      t.references :sequence
      t.references :cc_all
      t.integer :order

      t.timestamps
    end
  end

  def self.down
    drop_table :sequence_items
  end
end

class DropSequenceItems < ActiveRecord::Migration
  def self.up
    drop_table :sequence_items
  end

  def self.down
    create_table :sequence_items do |t|
      t.string :textid
      t.references :cc_sequence
      t.references :cc_all
      t.integer :position

      t.timestamps
    end
  end
end

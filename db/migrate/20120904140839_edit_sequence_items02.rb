class EditSequenceItems02 < ActiveRecord::Migration
  def self.up
    change_table :sequence_items do |t|
      t.rename :order, :position
    end
  end

  def self.down
    change_table :sequence_items do |t|
      t.rename :position, :order
    end
  end
end

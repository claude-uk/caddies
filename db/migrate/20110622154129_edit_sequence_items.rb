class EditSequenceItems < ActiveRecord::Migration
  def self.up
    change_table :sequence_items do |t|
      t.rename :sequence_id, :cc_sequence_id
    end
  end

  def self.down
    change_table :sequence_items do |t|
      t.rename :cc_sequence_id, :sequence_id
    end
  end
end

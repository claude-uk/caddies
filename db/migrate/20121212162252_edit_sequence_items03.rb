class EditSequenceItems03 < ActiveRecord::Migration
  def self.up
    change_table :sequence_items do |t|
      t.remove :textid
      t.boolean :ifbranch
      t.rename :cc_sequence_id, :parent_cc_all_id
    end
  end

  def self.down
    change_table :sequence_items do |t|
      t.string :textid
      t.remove :ifbranch
      t.rename :parent_cc_all_id, :cc_sequence_id
    end
  end
end

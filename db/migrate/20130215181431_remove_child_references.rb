class RemoveChildReferences < ActiveRecord::Migration
  def self.up
    change_table :cc_loops do |t|
      t.remove :cc_all_id
    end
    change_table :cc_ifthenelses do |t|
      t.remove :if_cc_all_id
      t.remove :else_cc_all_id
    end
  end

  def self.down
    change_table :cc_loops do |t|
      t.references :cc_all
    end
    change_table :cc_ifthenelses do |t|
      t.references :if_cc_all
      t.references :else_cc_all
    end
  end
end

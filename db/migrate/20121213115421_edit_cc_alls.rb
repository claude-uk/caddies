class EditCcAlls < ActiveRecord::Migration
  def self.up
    change_table :cc_alls do |t|
      t.integer :parent_id
      t.integer :position
      t.boolean :ifbranch
    end
  end

  def self.down
    change_table :cc_alls do |t|
      t.remove :parent_id
      t.remove :position
      t.remove :ifbranch
    end
  end
end

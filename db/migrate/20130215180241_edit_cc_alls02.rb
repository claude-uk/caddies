class EditCcAlls02 < ActiveRecord::Migration
  def self.up
    change_table :cc_alls do |t|
      t.remove :cc_type_id
    end
  end

  def self.down
    change_table :cc_alls do |t|
      t.references :cc_type
    end
  end
end

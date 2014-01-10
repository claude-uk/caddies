class EditTxtid < ActiveRecord::Migration
  def self.up
    change_table :cc_sequences do |t|
      t.rename :txtid, :textid
    end
    change_table :cc_statements do |t|
      t.rename :txtid, :textid
    end
  end

  def self.down
    change_table :cc_sequences do |t|
      t.rename :textid, :txtid
    end
    change_table :cc_statements do |t|
      t.rename :textid, :txtid
    end
  end
end

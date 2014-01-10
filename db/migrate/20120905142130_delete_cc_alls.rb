class DeleteCcAlls < ActiveRecord::Migration
  def self.up
    drop_table :cc_alls
  end

  def self.down
  end
end

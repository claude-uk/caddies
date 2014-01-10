class CreateCcIfthenelses < ActiveRecord::Migration
  def self.up
    create_table :cc_ifthenelses do |t|
      t.string :textid
      t.string :condition
      t.integer :if_cc_all_id
      t.integer :else_cc_all_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cc_ifthenelses
  end
end

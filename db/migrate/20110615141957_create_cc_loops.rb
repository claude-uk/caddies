class CreateCcLoops < ActiveRecord::Migration
  def self.up
    create_table :cc_loops do |t|
      t.string :textid
      t.string :loop_variable
      t.integer :initial_value
      t.integer :end_value
      t.string :loop_while
      t.references :cc_all

      t.timestamps
    end
  end

  def self.down
    drop_table :cc_loops
  end
end

class CreateCcAlls02 < ActiveRecord::Migration
  def self.up
    create_table :cc_alls do |t|
      t.references :cc_type
      t.string :construct_type
      t.integer :construct_id
      t.timestamps
    end
  end

  def self.down
    drop_table :cc_alls
  end
end

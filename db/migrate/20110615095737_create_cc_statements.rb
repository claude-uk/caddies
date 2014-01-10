class CreateCcStatements < ActiveRecord::Migration
  def self.up
    create_table :cc_statements do |t|
      t.string :txtid
      t.string :statement_item

      t.timestamps
    end
  end

  def self.down
    drop_table :cc_statements
  end
end

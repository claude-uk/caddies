class CreateCcSequences < ActiveRecord::Migration
  def self.up
    create_table :cc_sequences do |t|
      t.string :txtid

      t.timestamps
    end
  end

  def self.down
    drop_table :cc_sequences
  end
end

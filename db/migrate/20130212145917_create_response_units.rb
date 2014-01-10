class CreateResponseUnits < ActiveRecord::Migration
  def self.up
    create_table :response_units do |t|
      t.string :text

      t.timestamps
    end
  end

  def self.down
    drop_table :response_units
  end
end

class EditInstance03 < ActiveRecord::Migration
  def self.up
    change_table :instances do |t|
      t.remove :resource_package
    end
  end

  def self.down
    change_table :instances do |t|
      t.string :resource_package
    end
  end
end

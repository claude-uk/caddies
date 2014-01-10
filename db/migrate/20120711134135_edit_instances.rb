class EditInstances < ActiveRecord::Migration
  def self.up
    change_table :instances do |t|
      t.rename :ddata_collection_id, :ddata_collection
    end
  end

  def self.down
    change_table :instances do |t|
      t.rename :ddata_collection, :ddata_collection_id
    end
  end
end

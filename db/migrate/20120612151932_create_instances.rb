class CreateInstances < ActiveRecord::Migration
  def self.up
    create_table :instances do |t|
      t.string :agency
      t.string :version
      t.string :instance
      t.string :inst_citation
      t.string :resource_package
      t.string :rp_citation
      t.string :purpose
      t.string :purpose_text      
      t.string :cc_scheme
      t.string :category_scheme
      t.string :question_scheme      
      t.string :ddata_collection_id
      t.string :instrument
      t.string :top_sequence
      t.timestamps
    end
  end

  def self.down
    drop_table :instances
  end
end

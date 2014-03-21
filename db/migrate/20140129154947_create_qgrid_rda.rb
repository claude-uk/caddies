class CreateQgridRda < ActiveRecord::Migration
  def self.up
    create_table :qgrid_rdas do |t|
      t.references :question_grid
      t.references :code
      t.references :response_domain_all
      t.timestamps
    end
  end

  def self.down
    drop_table :qgrid_rdas
  end
end

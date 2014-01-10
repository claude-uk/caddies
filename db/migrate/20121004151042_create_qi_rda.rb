class CreateQiRda < ActiveRecord::Migration
  def self.up
    create_table :qi_rdas do |t|
      t.references :question_item
      t.references :response_domain_all
      t.timestamps
    end
    change_table :question_items do |t|
      t.remove :response_domain_all_id
    end
  end

  def self.down
    drop_table :qi_rdas
    change_table :question_items do |t|
      t.references :response_domain_all
    end
  end
end

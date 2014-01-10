class CreateQuestionItems < ActiveRecord::Migration
  def self.up
    create_table :question_items do |t|
      t.string :textid
      t.string :literal
      t.string :intent
      t.references :response_domain_all

      t.timestamps
    end
  end

  def self.down
    drop_table :question_items
  end
end

class CreateCcQuestions < ActiveRecord::Migration
  def self.up
    create_table :cc_questions do |t|
      t.string :textid
      t.references :question_item
      t.string :response_unit

      t.timestamps
    end
  end

  def self.down
    drop_table :cc_questions
  end
end

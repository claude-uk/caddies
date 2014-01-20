class EditCcQuestions02 < ActiveRecord::Migration
  def self.up
    change_table :cc_questions do |t|
      t.rename :question_item_id, :question_reference_id
      t.string :question_reference_type
      execute("update cc_questions set question_reference_type = 'QuestionItem'")
    end
  end

  def self.down
    change_table :cc_questions do |t|
      t.rename :question_reference_id, :question_item_id
      t.remove :question_reference_type
    end
  end
end

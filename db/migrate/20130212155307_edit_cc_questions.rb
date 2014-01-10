class EditCcQuestions < ActiveRecord::Migration
  def self.up
    change_table :cc_questions do |t|
      t.remove :response_unit
      t.references :response_unit
    end
  end

  def self.down
    change_table :cc_questions do |t|
      t.remove :response_unit_id
      t.string :response_unit
    end
  end
end

class CreateCcQuestionUniverses < ActiveRecord::Migration
  def self.up
    create_table :cc_question_universes do |t|
      t.references :cc_question
      t.references :universe

      t.timestamps
    end
  end

  def self.down
    drop_table :cc_question_universes
  end
end

class CreateQuestionGrids < ActiveRecord::Migration
  def self.up
    create_table :question_grids do |t|
      t.string :textid
      t.string :literal
      t.string :intent

      t.timestamps
    end
  end

  def self.down
    drop_table :question_grids
  end
end

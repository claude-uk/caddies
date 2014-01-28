class EditQuestionGrids02 < ActiveRecord::Migration
  def self.up
    change_table :question_grids do |t|
      t.string :corner_label
    end
  end

  def self.down
    change_table :question_grids do |t|
      t.remove :corner_label
    end
  end
end

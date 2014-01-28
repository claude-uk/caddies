class EditQuestionGrids03 < ActiveRecord::Migration
  def self.up
    change_table :question_grids do |t|
      t.change_default( :vertical_roster_rows, 0)
    end
  end

  def self.down
    change_table :question_grids do |t|
      t.change_default( :vertical_roster_rows, nil)
    end
  end
end

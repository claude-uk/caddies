class EditQuestionGrids < ActiveRecord::Migration
  def self.up
    change_table :question_grids do |t|
      t.integer :vertical_codelist_id
      t.integer :vertical_roster_rows
      t.string :vertical_roster_label
      t.integer :horizontal_codelist_id
    end
  end

  def self.down
    change_table :question_grids do |t|
      t.remove :vertical_codelist_id
      t.remove :vertical_roster_rows
      t.remove :vertical_roster_label
      t.remove :horizontal_codelist_id
    end
  end
end

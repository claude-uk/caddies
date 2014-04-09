class AddInstructionReferences < ActiveRecord::Migration
  def self.up
    change_table :question_items do |t|
      t.references :instruction
    end
    change_table :question_grids do |t|
      t.references :instruction
    end
  end

  def self.down
    change_table :question_items do |t|
      t.remove :instruction_id
    end
    change_table :question_grids do |t|
      t.remove :instruction_id
    end
  end
end

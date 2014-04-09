class EditInstructions < ActiveRecord::Migration
  def self.up
    change_table :instructions do |t|
      t.rename :InstructionText, :instruction_text
    end
  end

  def self.down
    change_table :instructions do |t|
      t.rename :instruction_text, :InstructionText
    end
  end
end

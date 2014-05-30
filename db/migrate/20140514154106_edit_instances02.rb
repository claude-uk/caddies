class EditInstances02 < ActiveRecord::Migration
  def self.up
    change_table :instances do |t|
      t.rename :instance, :prefix
      t.rename :purpose, :instrument_scheme
      t.string :question_grid_scheme
      t.string :instruction_scheme
      t.string :code_list_scheme
      t.string :mrep_text_scheme
      t.string :mrep_num_scheme
      t.string :mrep_dt_scheme
    end
  end

  def self.down
    change_table :instances do |t|
      t.rename :prefix, :instance
      t.rename :instrument_scheme, :purpose
      t.remove :question_grid_scheme
      t.remove :instruction_scheme
      t.remove :code_list_scheme
      t.remove :mrep_text_scheme
      t.remove :mrep_num_scheme
      t.remove :mrep_dt_scheme
    end
  end
end

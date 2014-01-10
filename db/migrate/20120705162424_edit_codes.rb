class EditCodes < ActiveRecord::Migration
  def self.up
    change_table :codes do |t|
      t.change(:cs_value, :string)
    end
  end

  def self.down
    change_table :codes do |t|
      t.change(:cs_value, :integer)
    end
  end
end

class EditResponseDomainTexts < ActiveRecord::Migration
  def self.up
    change_table :response_domain_texts do |t|
      t.column :label, :string
    end
  end

  def self.down
    change_table :response_domain_texts do |t|
      t.remove :label
    end
  end
end

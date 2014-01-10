class CreateResponseDomainTexts < ActiveRecord::Migration
  def self.up
    create_table :response_domain_texts do |t|
      t.integer :maxlen

      t.timestamps
    end
  end

  def self.down
    drop_table :response_domain_texts
  end
end

class CreateResponseDomainCodes < ActiveRecord::Migration
  def self.up
    create_table :response_domain_codes do |t|
      t.references :code_scheme

      t.timestamps
    end
  end

  def self.down
    drop_table :response_domain_codes
  end
end

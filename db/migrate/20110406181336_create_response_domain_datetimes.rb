class CreateResponseDomainDatetimes < ActiveRecord::Migration
  def self.up
    create_table :response_domain_datetimes do |t|
      t.references :datetime_type

      t.timestamps
    end
  end

  def self.down
    drop_table :response_domain_datetimes
  end
end

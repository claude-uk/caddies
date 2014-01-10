class EditResponseDomainDatetimes < ActiveRecord::Migration
  def self.up
    change_table :response_domain_datetimes do |t|
      t.column :label, :string
      t.column :format, :string
    end
  end

  def self.down
    change_table :response_domain_datetimes do |t|
      t.remove :label
      t.remove :format
    end
  end
end

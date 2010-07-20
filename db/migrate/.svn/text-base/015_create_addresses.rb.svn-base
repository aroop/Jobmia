class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :address_1, :address_2, :city, :state, :postal_code, :country, :phone_number, :fax_number, :email,  :website, :addressable_type
      t.integer :addressable_id
    end
  end

  def self.down
    drop_table :addresses
  end
end
class CreateProductInstances < ActiveRecord::Migration
  def change
    create_table :product_instances do |t|
      t.string :product_key
      t.integer :client_id
      t.string :product_title
      t.integer :product_location_address_id
      t.string :signator_first_name
      t.string :signator_last_name
      t.string :signator_email_address
      t.string :signator_telephone_number
      t.integer :product_type_id

      t.timestamps
    end
  end
end

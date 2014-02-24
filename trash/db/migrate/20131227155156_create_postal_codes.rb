class CreatePostalCodes < ActiveRecord::Migration
  def change
    create_table :postal_codes do |t|
      t.string :street
      t.string :city
      t.primary_key :id
      t.string :country
      t.integer :country_id
      t.integer :state_province_county_id
      t.string :postal_code

      t.timestamps
    end
  end
end

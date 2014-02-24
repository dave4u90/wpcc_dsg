class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :product_type_id
      t.string :registration_key

      t.timestamps
    end
  end
end

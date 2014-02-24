class CreateProductKeys < ActiveRecord::Migration
  def change
    create_table :product_keys do |t|
      t.primary_key :id
      t.integer :product_type_id
      t.string :product_key

      t.timestamps
    end
  end
end

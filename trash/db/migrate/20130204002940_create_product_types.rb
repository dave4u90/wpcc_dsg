class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :product_type_name
      t.string :product_type_description
      t.string :upc_code
      t.string :wpcc
      t.string :release_id
      t.integer :num_formplates

      t.timestamps
    end
  end
end

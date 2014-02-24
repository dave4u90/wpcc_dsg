class CreateProductTypeComponents < ActiveRecord::Migration
  def change
    create_table :product_type_components do |t|
      t.integer :product_type_id
      t.integer :component_id
      t.integer :sequence

      t.timestamps
    end
  end
end

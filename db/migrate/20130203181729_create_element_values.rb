class CreateElementValues < ActiveRecord::Migration
  def change
    create_table :element_values do |t|
      t.string :element_value
      t.integer :form_element_id
      t.integer :product_instance_id
      t.integer :form_instance_id

      t.timestamps
    end
  end
end

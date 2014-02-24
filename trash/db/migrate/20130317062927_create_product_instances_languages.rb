class CreateProductInstancesLanguages < ActiveRecord::Migration
  def change
    create_table :product_instances_languages do |t|
      t.integer :language_id
      t.integer :product_instance_id
      t.integer :sequence

      t.timestamps
    end
  end
end

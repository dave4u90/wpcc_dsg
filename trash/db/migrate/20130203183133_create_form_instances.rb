class CreateFormInstances < ActiveRecord::Migration
  def change
    create_table :form_instances do |t|
      t.integer :form_id
      t.integer :language_id
      t.integer :form_instance_type_id
      t.integer :formplate_id
      t.integer :product_instance_id 
      t.string :created

      t.timestamps
    end
  end
end

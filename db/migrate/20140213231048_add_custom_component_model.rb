class AddCustomComponentModel < ActiveRecord::Migration
  def change
    create_table :custom_components do |t|

      t.integer :component_id
      t.integer :product_instance_id
      t.integer :sequence
      
      t.string :custom_component_title
      
 
    end
  end
end

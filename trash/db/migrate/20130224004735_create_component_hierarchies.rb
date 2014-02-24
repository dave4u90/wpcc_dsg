class CreateComponentHierarchies < ActiveRecord::Migration
  def change
    create_table :component_hierarchies do |t|
      t.primary_key :id
      t.integer :parent_component_id
      t.integer :component_id
      t.integer :sequence

      t.timestamps
    end
  end
end

class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :component_description
      t.string :component_code
      t.integer :component_type_id
      t.string :upc_code
      t.integer :direct_sub_components
      t.integer :num_formplates

      t.timestamps
    end
  end
end

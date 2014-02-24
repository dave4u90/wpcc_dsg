class CreateComponentTypes < ActiveRecord::Migration
  def change
    create_table :component_types do |t|
      t.string :component_type_description
      t.integer :sequence
      t.boolean :supports_sub_components
      t.boolean :is_conceptual

      t.timestamps
    end
  end
end

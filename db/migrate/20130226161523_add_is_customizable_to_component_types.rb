class AddIsCustomizableToComponentTypes < ActiveRecord::Migration
  def change
  	add_column :component_types, :is_customizable, :boolean
  end
end

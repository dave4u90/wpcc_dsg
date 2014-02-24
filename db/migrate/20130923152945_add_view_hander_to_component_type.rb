class AddViewHanderToComponentType < ActiveRecord::Migration
  def change
    add_column :component_types, :view_handler, :text, :default =>  "box"
  end
end

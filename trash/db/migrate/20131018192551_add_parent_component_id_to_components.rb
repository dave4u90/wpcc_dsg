class AddParentComponentIdToComponents < ActiveRecord::Migration
  def change
    add_column :components, :parent_component_id, :integer

  end
end

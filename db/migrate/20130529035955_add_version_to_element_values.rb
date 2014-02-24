class AddVersionToElementValues < ActiveRecord::Migration
  def change
    add_column :element_values, :form_instance_version_id, :integer
  end
end

class AddCustomOrStandardFormInstance < ActiveRecord::Migration
  def change
    add_column :form_instances, :is_custom, :boolean
  end
end

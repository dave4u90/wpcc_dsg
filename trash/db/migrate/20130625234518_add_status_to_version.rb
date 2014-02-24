class AddStatusToVersion < ActiveRecord::Migration
  def change
    add_column :form_instance_versions, :status_id, :integer, default: 0
  end
end

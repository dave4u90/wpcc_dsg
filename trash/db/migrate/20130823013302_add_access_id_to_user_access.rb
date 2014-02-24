class AddAccessIdToUserAccess < ActiveRecord::Migration
  def change
    add_column :user_access, :access_role_id, :integer, default: 0
  end
end

class AddAdditionalFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false

    add_column :users, :address_id, :integer

    add_column :users, :client_id, :integer

  end
end

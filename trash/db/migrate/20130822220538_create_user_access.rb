class CreateUserAccess < ActiveRecord::Migration
  def change
    create_table :user_access do |t|
      t.integer :user_id
      t.primary_key :id
      t.integer :product_instance_id
      
      t.timestamps
    end
  end
end

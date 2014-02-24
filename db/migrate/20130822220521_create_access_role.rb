class CreateAccessRole < ActiveRecord::Migration
  def change
    create_table :access_role do |t|
      t.string :role_description
      t.primary_key :id
      t.string :key
      
      t.timestamps
    end
  end
end

class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.primary_key :id
      t.text :note
      t.integer :user_id
      t.integer :product_instance_id

      t.timestamps
    end
  end
end

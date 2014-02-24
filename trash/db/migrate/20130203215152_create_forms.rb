class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :product_form_nickname
      t.integer :status_id, :default => 1
      t.datetime :status_date
      t.integer :product_instance_id
      t.boolean :is_applicable
      t.integer :formplate_id

      t.timestamps
    end
  end
end

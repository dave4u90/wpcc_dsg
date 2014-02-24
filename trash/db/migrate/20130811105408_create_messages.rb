class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :id
      t.integer :user_id
      t.integer :language_id
      t.text :message
      t.text :subject

      t.timestamps
    end
  end
end

class CreateLiterals < ActiveRecord::Migration
  def change
    create_table :literals do |t|
      t.primary_key :id
      t.integer :literal_identifier_id
      t.string :literal_identifier_type
      t.integer :language_id
      t.text :literal

      t.timestamps
    end
  end
end

class CreateApplicationDictionaries < ActiveRecord::Migration
  def change
    create_table :application_dictionaries do |t|
      t.primary_key :id
      t.string :literal_key
      t.timestamps
    end
  end
end

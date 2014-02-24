class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.primary_key :id
      t.string :cityname
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end

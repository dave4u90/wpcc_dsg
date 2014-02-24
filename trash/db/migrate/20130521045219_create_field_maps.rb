class CreateFieldMaps < ActiveRecord::Migration
  def change
    create_table :field_maps do |t|

      t.timestamps
    end
  end
end

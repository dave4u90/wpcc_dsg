class CreateLiteralTypes < ActiveRecord::Migration
  def change
    create_table :literal_types do |t|
      t.string :table_name
      t.string :class_name
      t.primary_key :id

      t.timestamps
    end
  end
end

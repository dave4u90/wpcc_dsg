class CreateDLoggers < ActiveRecord::Migration
  def change
    create_table :d_loggers do |t|
      t.string :name
      t.string :description
      t.primary_key :id

      t.timestamps
    end
  end
end

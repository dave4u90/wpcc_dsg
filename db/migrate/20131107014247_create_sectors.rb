class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.primary_key :id
      t.string :sector

      t.timestamps
    end
  end
end

class CreateComponentFormplates < ActiveRecord::Migration
  def change
    create_table :component_formplates do |t|
      t.primary_key :id
      t.integer :component_id
      t.integer :formplate_id
      t.integer :sequence

      t.timestamps
    end
  end
end

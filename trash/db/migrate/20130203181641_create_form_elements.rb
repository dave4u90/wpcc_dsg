class CreateFormElements < ActiveRecord::Migration
  def change
    create_table :form_elements do |t|
      t.integer :formplate_id
      t.string :caption
      t.string :default_value
      t.integer :element_type_id
      t.string :html_residue
      t.string :style
      t.integer :sequence
      t.string :csv_list
      t.string :sql_list
      t.integer :max_length
      t.boolean :is_printed
      t.boolean :is_mandatory

      t.timestamps
    end
  end
end

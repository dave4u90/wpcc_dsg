class CreateFormplates < ActiveRecord::Migration
  def change
    create_table :formplates do |t|
      t.string :title
      t.integer :validity
      t.integer :page_layout_id
      t.string :form_code
      t.integer :language_id

      t.timestamps
    end
  end
end

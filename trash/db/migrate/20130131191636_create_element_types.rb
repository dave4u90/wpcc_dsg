class CreateElementTypes < ActiveRecord::Migration
  def change
    create_table :element_types do |t|
      t.string :element_name
      t.string :htmltag
      t.string :csvlist
      t.string :sqllist
      t.boolean :islist
      t.boolean :isglobal
      t.boolean :has_inner_value_type
      t.string :html_close_tag
      t.string :element_value_field
      t.boolean :has_caption
      t.boolean :is_editable
      t.integer :max_length
      t.string :html_class

      t.timestamps
    end
  end
end

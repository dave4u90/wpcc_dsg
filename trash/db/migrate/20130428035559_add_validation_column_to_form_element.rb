class AddValidationColumnToFormElement < ActiveRecord::Migration
  def change
    add_column :element_types, :validation_id, :integer
    add_column :form_elements, :validation_id, :integer
  end
end

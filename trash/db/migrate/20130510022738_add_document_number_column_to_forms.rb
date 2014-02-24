class AddDocumentNumberColumnToForms < ActiveRecord::Migration
  def change
    add_column :forms, :document_number, :text
    add_column :forms, :legislations, :text
  end
end

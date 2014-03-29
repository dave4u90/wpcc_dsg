class AddIsDraftToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :is_draft, :boolean, default: true
    Note.reset_column_information
    Note.update_all is_draft: false
  end
end

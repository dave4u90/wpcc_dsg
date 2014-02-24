class AddNoteObjectTypeToNote < ActiveRecord::Migration
  def change
    add_column :notes, :note_object_type, :string
  end
end

class AddComponentSubjectToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :subject, :text
    add_column :notes, :component_id, :integer
  end
end

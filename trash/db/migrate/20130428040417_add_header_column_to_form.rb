class AddHeaderColumnToForm < ActiveRecord::Migration
  def change
    add_column :forms, :prepared_by_user_id, :integer
    add_column :forms, :review, :date
    add_column :forms, :amended, :date
    add_column :forms, :location, :text
    add_column :forms, :documents, :text
 
  end
end

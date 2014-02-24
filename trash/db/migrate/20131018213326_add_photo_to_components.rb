class AddPhotoToComponents < ActiveRecord::Migration
  def change
    add_column :components, :photo, :string

  end
end

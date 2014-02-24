class AddImageColumnToComponents < ActiveRecord::Migration
  def change
    add_column :components, :image_url, :text, default: 0
  end
end

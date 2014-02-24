class AddImageIdToComponent < ActiveRecord::Migration
  def change
    add_column :components, :image_id, :integer
  end
end

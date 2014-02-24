class AddImageColumnsToProductType < ActiveRecord::Migration
  def change
      add_column :product_types, :icon_url, :string      
  end
end

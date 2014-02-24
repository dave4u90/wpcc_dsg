class AddPostCodeToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :post_zip_code, :string

  end
end

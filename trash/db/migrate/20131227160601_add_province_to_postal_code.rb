class AddProvinceToPostalCode < ActiveRecord::Migration
  def change
    add_column :postal_codes, :province, :string
  end
end

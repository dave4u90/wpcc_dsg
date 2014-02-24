class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :client_name
      t.integer :sector_id
      t.integer :address_id
      t.string :watermark_image_url

      t.timestamps
    end
  end
end

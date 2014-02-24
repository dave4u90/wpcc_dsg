class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.primary_key :id
      t.string :image_url
      t.decimal :height_width_ratio

      t.timestamps
    end
  end
end

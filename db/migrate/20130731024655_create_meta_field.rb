class CreateMetaField < ActiveRecord::Migration
  def change
    create_table :metafield do |t|
      t.integer :metafield_identifier_id
      t.string :metafield_identifier_type
      t.primary_key :id

      t.string :key
      
      t.timestamps
    end
  end
end

class CreateMetaData < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.integer :metadata_identifier_id
      t.string :metadata_identifier_type
      t.primary_key :id
      t.string :key
      t.integer :metafield_id
      
      t.timestamps
    end
  end

end

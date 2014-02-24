class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.primary_key :id
      t.string :file_name
      t.string :content_type
      t.string :file_size

      t.timestamps
    end
  end
end

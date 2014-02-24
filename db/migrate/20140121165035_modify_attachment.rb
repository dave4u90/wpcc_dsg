class ModifyAttachment < ActiveRecord::Migration
  def change
      create_table :attachments do |t|
        #t.remove :file_name, :content_type, :file_size
        t.string :upload_file_name
        t.string :upload_content_type
        t.integer :upload_file_size
        t.datetime "upload_updated_at"
      
        t.integer :attachment_identifier_id
        t.string :attachment_identifier_type
        t.integer :language_id
      
        t.string :search_tags    
    end
  end
end

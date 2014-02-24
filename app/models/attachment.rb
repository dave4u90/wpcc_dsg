class Attachment < ActiveRecord::Base
  attr_accessible :attachment
  has_attached_file :attachment, :s3_credentials => "c:/ruby193/wpcc_new/config/s3.yml" , :path => ":attachment/:id/:style.:extension", :bucket => 'wpcc_talott_documents'
  

  include Rails.application.routes.url_helpers
  
  
  def self.allowed_file_types()
    allowed_file_types = ['PNG', 'GIF', 'JPG', 'DOC', 'DOCX', 'XLS', 'XLSX', 'PDF']
    return allowed_file_types
  end
  def self.allowed_file_types_to_csv()
    k = Attachment.allowed_file_types
    s = ''
    s = k.to_s
    return s
  end
  def self.min_file_size()
    return 0
  end
  def self.max_file_size()
    #in mb
    return 5
  end
  def self.max_files_count()
    return 5
  end
  
  def get_filename()
    return upload_file_name
  end
  
  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => attachment_path(self),
      "delete_type" => "DELETE" 
    }
  end
  
  
end

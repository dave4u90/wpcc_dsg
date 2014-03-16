class Attachment < ActiveRecord::Base
  attr_accessible :upload
  belongs_to :attachment_identifier
  has_attached_file :upload,
                    storage: :s3,
                    bucket: 'talott_wpcc_forms',
                    s3_credentials: {access_key_id: 'AKIAIJYE5DCLWM432DDQ', secret_access_key: '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'}

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

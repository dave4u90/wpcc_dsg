Paperclip::Attachment.default_options[:path] = '/:class/:attachment_identifier_type/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = 's3.amazonaws.com'

Paperclip.interpolates :attachment_identifier_type do |attachment, style|
  attachment.instance.attachment_identifier_type.to_s
end
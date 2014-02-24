S3DirectUpload.config do |c|
  c.access_key_id = "AKIAIJYE5DCLWM432DDQ"       # your access key id
  c.secret_access_key = "1uBWEFnN6AH5nv8EYSHy+6mQModGu/SsgDMVxaWa"   # your secret access key
  c.bucket = "talott_wpcc_forms"              # your bucket name
  c.region = nil             # region prefix of your bucket url (optional), eg. "s3-eu-west-1"
  c.url = "https://talott_wpcc_forms.s3.amazonaws.com"                # S3 API endpoint (optional), eg. "https://#{c.bucket}.s3.amazonaws.com/"
end
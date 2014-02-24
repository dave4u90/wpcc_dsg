namespace :wpcc do
  desc "Creating admin"
  task :create_client=> :environment do
    u = Client.new(:client_name=>"Krishna",:sector_id => 1, :address_id => 1, :watermark_image_url =>"ss" )
    u.save 
  end 
  
  
  task :update_users => :environment do
    
    admin = User.find_by_email("simpsonjt66@gmail.com")
    admin.admin = 1
    admin.save(:validate => false)  
    
    users = User.all
    users.each do |u|
      u.client_id = 1
      u.save(:validate => false)  
    end
    
  end 
  
end

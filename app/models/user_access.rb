class UserAccess < ActiveRecord::Base
  self.table_name = "user_access"
  
  
  belongs_to :product_instance
  belongs_to :user
  belongs_to :access_role
  
  def is_administrator()
    if self.access_role
      return self.access_role.is_administrator
    else
      return false
    end
    
  end
  def is_crud()
    if self.access_role
     return self.access_role.is_crud
    else
      return false
    end 
  end
  def self.find_administrators(my_ua) 
    return self.find_administrators_by_product_instance(my_ua.product_instance_id) 
  end
  def self.find_administrators_by_product_instance(product_instance_id)
    users = UserAccess.where ("product_instance_id=" + product_instance_id.to_s)
    admins = []
    users.each do |u|
      if u.is_administrator
        admins.push u
      end
    end
    
    return admins 
  end
  
  
  def remove_access()
    ua = self
    if ua == nil
      return false
    else
      #check to see if this is the last standing admin for the product_instance
      admin_check = false
      if ua.is_administrator
        admins = UserAccess.find_administrators (ua)
        admin_check = admins.size <= 1
      end
      
      if admin_check
        return false
      else
        UserAccess.delete self.id
      end      
    end
    
  end
  
  

  
end

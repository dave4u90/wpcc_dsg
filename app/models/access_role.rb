class AccessRole < ActiveRecord::Base
  self.table_name = "access_role"
  
  has_many :literals, :as => :literal_identifier

  def is_administrator()
    if self.key == "administrator"
      return true
    else
      return false
    end
    
  end
  def is_crud()
    if self.key == "crud"
      return true
    else
      return false
    end
    
  end
  def is_talott()
    if self.key == "talott"
      return true
    else
      return false 
    end
    
  end
  def self.get_administrator_id()
    all = AccessRole.all
    all.each do |ar|
      if ar.is_administrator
        return ar.id
      end      
    end
  end

  def self.get_crud_id()
    all = AccessRole.all
    all.each do |ar|
      if ar.is_crud
        return ar.id
      end      
    end
  end
  
  def get_title(language_id)
    if self.literals.size > 1 
      l = self.literals.first.get_literal(language_id)
      return l.literal
    else
      return role_description
    end    
  end

  
end

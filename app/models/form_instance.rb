# == Schema Information
#
# Table name: form_instances
#
#  id                    :integer          not null, primary key
#  form_id               :integer
#  language_id           :integer
#  form_instance_type_id :integer
#  formplate_id          :integer
#  product_instance_id     :integer
#  created               :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  is_custom             :boolean
#

class FormInstance < ActiveRecord::Base
  belongs_to :language
  belongs_to :formplate
  belongs_to :form
  has_many :meta_data 
  has_many :meta_field
  has_many :form_instance_versions, :order => "updated_at DESC"
  

  def create_new_version(user_id)
    k = self.form_instance_versions.new()
    if self.form_instance_versions.empty?
      k.version = 1
      k.revision = 0
    else
      k.version = self.form_instance_versions.first.version + 1
      k.revision = 0
    end
    k.user_id = user_id
    k.save()
    
    DLogger.log self, "new version created. k=" + k.to_json
    
    return k        
    
  end
  
  def create_new_revision(user_id)
    k = self.form_instance_versions.new()
    if self.form_instance_versions.empty?
      k.version = 1
      k.revision = 0
    else
      k.version = self.form_instance_versions.first.version
      if self.form_instance_versions.first.revision == nil
        self.form_instance_versions.first.revision = 0
      end      
      k.revision = self.form_instance_versions.first.revision + 1
    end
    k.user_id = user_id
    k.save()    
    return k        
  end

  def get_current_version(user_id)
    #the current version is the most recent version, which is the first
    #if first does not exist then we need to create a version
    k = self.form_instance_versions.first
    
    if k == nil
      k = self.form_instance_versions.new
      k.user_id = user_id
      k.save
      return k
    end
    
 
 
    DLogger.log self, "user-id: " + user_id.to_s + " and k.user_id=" + k.user_id.to_s + "<br>updated_at=" + k.updated_at.to_date.to_s + '=' + Time.now.to_date.to_s  

   
    #now we have to check if the current version is last saved today?
    #if it was last saved today by the same user, then thats the version we should return
    #otherwise: we should create a new version     
    if k.user_id == user_id
      #same user - so if its today then its the same version/revision
      if k.updated_at.to_date == Time.now.to_date
          return k
      else
          ###same user but different day - new revision
          k = create_new_revision(user_id)
          return k
      end
    else
      #differnet user - new revision
      k = create_new_revision(user_id)
      return k
    end      
    
  end
end

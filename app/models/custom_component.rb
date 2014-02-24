class CustomComponent < ActiveRecord::Base

  attr_accessible :component_id, :custom_component_title, :product_instance_id, :sequence
   
  has_many :attachments, :as => :attachment_identifier
  has_many :literals, :as => :literal_identifier
  
  
end
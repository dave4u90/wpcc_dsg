class ProductInstanceLanguage < ActiveRecord::Base
  self.table_name = "product_instances_languages"
  
  
  belongs_to :language
  belongs_to :product_instance
  
end

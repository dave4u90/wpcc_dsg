class MetaData < ActiveRecord::Base
   self.table_name = "metadata"
   
   
   belongs_to :product_instance
   belongs_to :product_type
   belongs_to :component
   belongs_to :component_type
   belongs_to :language
   
   belongs_to :meta_fields

end

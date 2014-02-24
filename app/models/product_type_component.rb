class ProductTypeComponent < ActiveRecord::Base
  belongs_to :component
  belongs_to :product_type

  
end

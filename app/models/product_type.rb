class ProductType < ActiveRecord::Base
  
  has_many :product_type_components, :order => "sequence ASC"
  has_many :components, :through => :product_type_components, :order => "sequence ASC"
  has_many :product_instances
  has_many :literals, :as => :literal_identifier
  
  has_many :product_keys
  
  has_many :meta_data 
  has_many :meta_fields, :as => :metafield_identifier
  
  def get_title(language_id)
    if self.literals.size > 1 
      l = self.literals.first.get_literal(language_id)
      return l.literal
    else
      return product_type_name
    end    
  end
  

  def get_components()
    #holder array
    comps = []
    
    #counters
    i=0
    j=0
    
    #temp
    t = nil
    
    array_comp = self.product_type_components.to_a 
    
    while i < array_comp.size do
      j = i+1
      t = array_comp[i]
      while j < array_comp.size do
        if t.sequence > array_comp[j].sequence
          t = array_comp[j]
        end
        j+=1
      end
      i+=1
      comps.push t.component
    end

    return comps
  end
  
end

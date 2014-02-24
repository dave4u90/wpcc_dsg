class FieldMap

  #a fieldmap is a map that is tied to a particular field in a given table or model. It can hold extended properties about a field.
  properties_hash = Hash.new 


  def self.get_property(my_hash, field_name, property_key)
    #code
    h = my_hash
    
    if my_hash.class.to_s != "Hash"
      return nil 
    end
    
    properties_hash = h
    
    if h.keys.include?(field_name)  
      if h[field_name].include?(property_key)
        return h[field_name][property_key]        
      else
        return nil
      end
      return nil
    end

  end
  
  def self.is_rendered(my_hash, field)
    res = FieldMap.get_property my_hash, field,"is_rendered"
    if res == nil
      return true
    else
      return res
    end
    
  end
  
    def self.has_inner_value(my_hash, field)
    res = FieldMap.get_property my_hash, field, "has_inner_value"
    if res == nil
      return false
    else
      return res
    end    
  end
  def self.is_read_only(my_hash, field)
    return FieldMap.get_property my_hash, field,"is_read_only"
  end
  def self.is_mandatory(my_hash, field)
    return FieldMap.get_property my_hash, field,"is_required"
  end
  def self.get_html_tag(my_hash, field)
    res = FieldMap.get_property my_hash, field,"html_tag"
    if res == nil
      return 'input'
    else
      res
    end
  end
  def self.get_html_residue(my_hash, field)
    res = FieldMap.get_property my_hash, field,"html_residue"
    if res == nil
      return ''
    else
      return res
    end    
  end
  
  def self.get_updateable_fields(my_hash)
    #loop through all the items in the hash, those that read only, add it to result array
    res = []
    my_hash.keys.each do |k|
      #check to see if this is a readonly field
      r = FieldMap.is_read_only my_hash, k
      if r != true
        res.push k
      end
      
    end
    
    return res
  end


  #this method will intelligently look at extended properties of the object, validate, and update the attributes
  #--for input, the 
  def self.update_object(obj, resp_param)
    
    if obj == nil
      return "nil"
    end

    
    #get extended properties hash of the object
    h = obj.get_extended_properties
    
    if h == nil
      return "nil"
    end 
    
    #get a list of updateable fields (non readonly)
    fields_to_update = FieldMap.get_updateable_fields(h)

    if fields_to_update == nil 
      return "nil"
    else
      if fields_to_update.size < 1
        return "nil"
      end
    end    
    
    #result msg
    res_msg = ">>"
    fields_to_update.each do |field|
      res_msg += field.downcase + "++"
      if resp_param.keys.include?(field.to_s.downcase)
              res_msg += field += "="  + resp_param[field.downcase] + ";<br>"
#              obj.update_attribute field, resp_param[field.downcase]
      end
      
    end
    obj.save
    res_msg += "<<" + resp_param.size.to_s
  
    return res_msg
  end
  
  
  
end

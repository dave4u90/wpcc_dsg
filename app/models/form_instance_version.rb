class FormInstanceVersion < ActiveRecord::Base
  has_many :element_values
  belongs_to :form_instance
  belongs_to :user
  belongs_to :status
  
  def save_value(element_id, value)
    self.element_values.each do |e|
      if e.form_element_id == element_id
        e.form_element_id = element_id
        e.element_value =  value
        e.save
        return e
      end      
    end
    
    
    #element value doesnt exist, so create a new record    
    p = self.element_values.new()
    p.form_element_id = element_id
    p.element_value = value
    p.save
    return p
  
  
  end

  def pdf_file_name
    return self.form_instance.form.get_title + 'v' + self.get_version
  end
  
  def get_element_value(element_id)
    self.element_values.each do |e|
      if e.form_element_id == element_id
        return e.element_value.to_s
      end      
    end
    
    return nil
  end
  
  def get_version()
    if self.revision == 0 
      return self.version.to_s + '.00'
    else
      v = BigDecimal(self.version.to_s) + ((BigDecimal(self.revision.to_s) / 100))
      return v.to_s
    end    
  end
  
  def is_edit_able
    return Status.is_edit_able self.status_id    
  end
  
end

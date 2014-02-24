# == Schema Information
#
# Table name: form_elements
#
#  id              :integer          not null, primary key
#  formplate_id    :integer
#  caption         :string(255)
#  default_value   :string(255)
#  element_type_id :integer
#  html_residue    :string(255)
#  style           :string(255)
#  sequence        :integer
#  csv_list        :string(255)
#  sql_list        :string(255)
#  max_length      :integer
#  is_printed      :boolean
#  is_mandatory    :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class FormElement < ActiveRecord::Base
  belongs_to :element_type
  has_many :element_values, :order => "created_at DESC"
  
  belongs_to :validation
  
  def get_caption(language_id)
    return self.caption
  end
  
  def get_value(fi)
    if self.element_values.empty?
      return self.default_value
    else
      return self.element_values[0].element_value
    end
  end
  
  #this method will save the value into the db
  #- only if its different than the current value
  def save_value(fi, bi, value, version)
    
    
    #current value
    my_value = self.get_value(fi)
    

    #check to see if current value is different then the new value
    if my_value != value
    
      #save the value thru the version variable
      v = version.save_value self.id, value    
      
      v.product_instance_id = bi.id
      v.form_instance_id  = fi.id

      v.save
      
      return v

    end
    
  end
  
  
  #this method will use regular expression to validate - the value
  def is_valid(value)
    #check direct validation
    if self.validation == nil
      #direct validation isnt available check with default validation in the element_type
      return self.element_type.default_validate_value(value)
    else
      if self.validation.empty?
        #direct validation not available, check with default validation in element_type
        return self.element_type.default_validate_value(value)
      else
        #direct validation is available.
        #validate. regular expression is stored in self.validation.expr
        return value.to_s.match(self.validation.expr) != nil        
      end
    end
    
  end
  
  def get_invalid_message(language_id)
    #this method will return the language appropriate validation message associated to this element
    
    
    #get validation object
    my_validation = self.get_validation_object
        
    #check to see if the validaiton object is empty
    if my_validation != nil
      if my validation.empty?        
        #if the validation object is empty -- this should almost never happen, but if it does return a standard
        #---return nothing
        return ""
      else
        #return the language appropriate validation message
        return my_validation.literals.get_literal(language_id)
      end
    else
        #if the validation object is empty -- this should almost never happen, but if it does return a standard
        #---return nothing  
         return ""   
    end
    
  end
  
  def get_validation_object()
    if self.validation == nil
      #direct validation doesnot exist, look for default in element_type
      return self.element_type.validation
    else
      if self.validation.empty?
        return self.element_type.validation
      else
        return self.validation
      end
    end
  end
  
  def is_new_line()
    if self.element_type == nil
      return false
    end
    if self.element_type.element_name.class == String
      return self.element_type.element_name.downcase == "newline"
    else
      return false
    end
  end
  
  
  def get_html_tag()
    if self.element_type == nil
      return 'input type="text" size="30"'
    else
      return self.element_type.htmltag.to_s
    end
  end
  
  def get_html_close_tag
    if self.element_type == nil
      return '</input>'
    else
      return self.element_type.html_close_tag.to_s
    end    
  end
  
  def is_list()
    if self.element_type == nil
      return false
    else
      return self.element_type.islist                  
    end
  end
  
  def is_sql_list()
    if self.element_type == nil
      return false
    else
      if self.element_type.isglobal
        return self.element_type.sqllist != nil
      else
        return self.sql_list != nil
      end
    end    
  end
  
  def is_global
    if self.element_type == nil
      return false
    else
      return self.element_type.isglobal  
    end
  end
  
  def get_list
    if self.is_list
      if self.is_sql_list
        sqlres = nil
#        sqlres = self.element_type.sqllist.to_s
        sql = self.element_type.sqllist.to_s.downcase
        sqlres = ActiveRecord::Base.connection.execute (sql)
        
        
        #--------convert sql_res into a standard array of values
        
        #temp_a is a temp array to hold values
        temp_a = sqlres.to_a
        
        #res_a is an array to hold the results
        res_a = []
        temp_a.each do |obj|
          res_a.push obj[0]
        end
        
        #--------->

        
        return res_a

      else
        if self.is_global
          return self.element_type.csvlist.split(",")
        else
          return self.csv_list.split(",")
        end
      end
    else
      return nil
    end
  end
  
end

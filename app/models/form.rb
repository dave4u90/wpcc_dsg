# == Schema Information
#
# Table name: forms
#
#  id                  :integer          not null, primary key
#  product_form_nickname :string(255)
#  status_id           :integer
#  status_date         :datetime
#  product_instance_id   :integer
#  is_applicable       :boolean
#  formplate_id        :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Form < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :product_instance
  belongs_to :formplate
  
  #the form_instance that was most recently updated should be be the final one.
  #if a previous form_instance should be read only, with an option to make current
  #then the previous form_instance would be copied
  has_many :form_instances, :order => "updated_at DESC"
  has_many :literals, :as => :literal_identifier
  
  
  def self.find_or_create_by_formplate(formplate, product_instance_id, user_id, current_language_id)
    #this is a class wide method which will search for formplate_id and product_instance_id. If not found, it will create
    f = Form.where ("formplate_id=" + formplate.id.to_s)
 
    if f.empty?
      return (create_form formplate, product_instance_id, user_id, current_language_id)
    else
      f2 = f.where "product_instance_id=" + product_instance_id.to_s
      if f2.empty?
        return (create_form formplate, product_instance_id, user_id, current_language_id)
      else
        return f2.first
      end      
    end
    
    return f
  end
  
  
  
  def self.create_form(formplate, product_instance_id, user_id, current_language_id)
    
      f = Form.new
      f.formplate_id = formplate.id
      f.product_instance_id = product_instance_id
      f.product_form_nickname = formplate.get_title (current_language_id)
      f.prepared_by_user_id = user_id
      f.save
      
      
      fl = f.literals.new
      fl.literal = f.product_form_nickname
      fl.language_id = current_language_id
      fl.save
      
      return f
  
  end

  
  #define fieldmap for extended properties  
  def get_extended_property(field_name, property_key)
    
    ###define extended properties here
    extended_properties = Hash.new
    
    ##extended_properties has contains field names as keys. the values of these keys are Hash describiting their property values
    ##if a field does not exist in the extended_properties has, then it means it has no extended propertie
    ##---hard code the extended properties here. this is business logic.
    extended_properties["product_form_nickname"] = Hash["tab_order" => 1, "validation_regex" => "", "is_read_only" => false, "is_required" => true, "is_rendered" => true]
    extended_properties["document_number"] = Hash["tab_order" => 2, "validation_regex" => "", "is_read_only" => true, "is_required" => true, "is_rendered" => true]

    extended_properties["created_at"] = Hash["tab_order" => 3, "validation_regex" => "", "is_read_only" => true, "is_rendered" => true, "html_residue" => " class='datepicker'"]
    extended_properties["review"] = Hash["tab_order" => 4, "validation_regex" => "", "is_read_only" => false, "is_rendered" => true, "html_residue" => " class='datepicker'"]
    extended_properties["amended"] = Hash["tab_order" => 5, "validation_regex" => "", "is_read_only" => true, "is_rendered" => true, "html_residue" => " class='datepicker'"]

    extended_properties["location"] = Hash["tab_order" => 6, "validation_regex" => "", "is_read_only" => false, "is_rendered" => true, "html_tag" => "textarea", "has_inner_value" => true, "html_residue" => " cols='40' rows='3' "]
    extended_properties["legislations"] = Hash["tab_order" => 7, "validation_regex" => "", "is_read_only" => false, "is_rendered" => true, "html_tag" => "textarea", "has_inner_value" => true, "html_residue" => " cols='40' rows='3' "]
    extended_properties["documents"] = Hash["tab_order" => 8, "validation_regex" => "", "is_read_only" => false, "is_rendered" => true, "html_tag" => "textarea", "has_inner_value" => true, "html_residue" => " cols='40' rows='3' "]

    extended_properties["id"] = Hash["is_rendered" => false]
    extended_properties["status_id"] = Hash["is_rendered" => false]
    extended_properties["product_instance_id"] = Hash["is_rendered" => false]
    extended_properties["updated_at"] = Hash["is_rendered" => false]
    extended_properties["status_date"] = Hash["is_rendered" => false]
    extended_properties["formplate_id"] = Hash["is_rendered" => false]
    extended_properties["is_applicable"] = Hash["is_rendered" => false]
        
    
    h = extended_properties
    return FieldMap.get_property(h, field_name, property_key)

    
  end
  
  
  def get_title(language_id)
    if self.literals.size >= 1 
      l = self.literals.first.get_literal(language_id)
      return l.to_s
    else
      return product_form_nickname
    end    
  end
  
  def get_sorted_attributes ()
    list = self.attributes.keys.to_a
    #my_a = []
  
      

    return list if list.size <= 1 # already sorted
    swapped = true
    while swapped do
      swapped = false
      0.upto(list.size-2) do |i|
        if tab_order(list[i]) > tab_order(list[i+1])
          list[i], list[i+1] = list[i+1], list[i] # swap values
          swapped = true
        end
      end    
    end
  
    return list
    
  end
  
  def tab_order(field)
    a = get_extended_property(field, "tab_order")
    #put fields that do not have a tab order defined at the bottom
    if a == nil
      return self.attributes.keys.size
    else
      return a
    end    
  end
  
  def get_form_instance_or_create(language_id)
    
    if self.form_instances.empty?
      return add_form_instance(language_id)
    else
      self.form_instances.each do |fi|
        if fi.language_id == language_id
          return fi
        end
      end
    end 
  end
  
  def add_form_instance(language_id)
    fi = self.form_instances.new()
    fi.language_id = language_id
    
    #standard by default
    fi.is_custom = false
    
    #formplate id will always be retreived from the parent form
    fi.formplate_id = self.formplate_id
    
    #save the record
    fi.save
    
    
    return fi       
  end
  
  def get_rendered_attributes()
    rendered_attributes = Hash.new
    self.attributes.each do |a|
      if self.is_rendered(a[0])
        rendered_attributes[a[0]] = a[1]
      end    
    end

    return rendered_attributes
  end
  
  def is_rendered(field)
    res = get_extended_property(field,"is_rendered")
    if res == nil
      return true
    else
      return res
    end
    
  end

  def has_inner_value(field)
    res = get_extended_property(field, "has_inner_value")
    if res == nil
      return false
    else
      return res
    end    
  end
  def is_read_only(field)
    return get_extended_property(field,"is_read_only")
  end
  def is_mandatory(field)
    return get_extended_property(field,"is_required")
  end
  def get_html_tag(field)
    res = get_extended_property(field,"html_tag")
    if res == nil
      return 'input'
    else
      res
    end
  end
  def get_html_residue(field)
    res = get_extended_property(field,"html_residue")
    if res == nil
      return ''
    else
      return res
    end    
  end
  def is_valid(field, value)
    return true
    str = value

    regex_expr = get_extended_property(field, "validation_regex")
    if regex_expr == ""
      return true
    else
      return str.match(regex_expr) != nil 
    end
    
  end

  def get_html_form_field(field)
    return 'f' + self.id.to_s + '_' + field  
  end
  
  
  #a product form will have names in multiple languages. this relationship is maintained
  ##--using literals. so change the literal for the provided language_id
  def change_form_custom_name(language_id, value)   
    if self.literals.empty?
      l = self.literals.new
      l.language_id = language_id
      l.literal = value
      l.save

    else
      k = (self.literals.where :language_id => language_id)
      if k.empty?
        l = self.literals.new 
        l.language_id = language_id
        l.literal = value
        l.save
      else
        l = k.first
        l.literal = value
        l.save
      end
      
    end
  end
  
  
  def get_form_custom_name(language_id)
    #find literals for current language
    
    if self.literals.empty?
      return self.product_form_nickname.to_s
    end 
  
    k = (self.literals.where :language_id => language_id)
  
    if k.empty?
        return self.literals.first.literal.to_s
    
    else      
      #this is the regular case - current language literals
      return k.first.literal.to_s
    
    end
  end

  ###redundant method
  def save_title(language_id, value)
    change_form_custom_name language_id, value
  end
end

class MetaField < ActiveRecord::Base
  self.table_name = "metafield"
  
  has_many :meta_data
  
  def get_meta_data(lang_id)
    #go thru the metadata and find matching metadata where lang_id 
    self.meta_data.each do |data|
      if data.language_id = lang_id
        return data
      end
    end
  end
  
  def get_title(language_id)
    if self.literals.size >= 1 
      l = self.literals.first.get_literal(language_id)
      return l.literal
    else
      return key
    end    
  end
  
  def html_s (lang_id)
    #this will return the HTML to generate the field and its corresponding metadata for current language filled.
    #if the language doesnt have a value - it will leave it empty
    
    #HTML naming convention for input name is mf_##_## ex: mf_10_44 (where 10 is the metafield.id, and 44 is the language.id) 
    
    s  = "<table border='0'><tr><td>"
    s += self.get_title(lang_id)
    s += "</td></tr><tr><td>"
    v = self.get_meta_data (lang_id)
    s += "<input type='text' name='mf_" + self.id + "_" + lang_id + "' value='" + v + "'/>"
    s += "</td></tr></table>"
    
  end
end
 
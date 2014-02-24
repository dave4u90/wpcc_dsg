module FormsHelper
  include ApplicationHelper
  
  def write_form_tab(i, l, fi)
    
    ###------------------------------------
    ###  This method will generate the HTML for the language tab.
    ###  i = index of the tab ()
    ###  l = l is the language object in which this form is being rendered
    ###  f = is the form object for which this form-tab is being rendered
    ###------------------------------------ 
    
        
    s = '<div id="tabs-' + i.to_s + '">'
        
    
    #render the form header - this is the information that are common to all forms

    s += '<div id="accordion">'
    s += "<h3>" + t(:form_header) + "</h3>"

    s+= "<div>"
    s += render_form_header (fi)    
    s += "</div>"
    
    #determine what type of form_instance it is. Either custom or standard
    #a custom form is a set of uploaded files
    #a standard form is formplate based
    if fi.is_custom
      s += t(:custom_form_type_description) + " "
      s += link_to t(:click_here_to_archive), "http://www.google.com"
      s += "<hr>"
    
      s += render_custom_contents(fi)
      
    else
      
      
      s += "<h3>" + t(:form_content) + ' (v' +  @current_version.get_version.to_s() + ")</h3>"
      #its a standard form - so generate the formplate with most recent information
      #
      #
    
      #start the accordion
      s += "<div>"
      
      #create HTML form tag
      #s+= form_for fi do |my_form|
        
          #add HTML to prompt user if they want to attach a file, they can link it.
      #   s += t(:standard_form_type_description) + " "
      #   s += link_to t(:click_here_to_attach), "http://www.google.com"
      
      
          #render the formplate
          #
          #s += "<hr>"
          s += "<p>"
          s += render_formplate(fi)
          s += "</p>"
      #end 

      s += "</div>"
      
    end
    
    #close the accordions
    s += "</div>"
    
    #close the tab
    s += "</div>"
    return s.html_safe
  
  end

  def render_form_header(fi)
    #render html for dates, last updated etc... for the current form.
    
    s = ''
    s += "<p>"
    
  
    #loop through the attributes that are supposed to be rendered and write them
    rendered_attributes = fi.form.get_sorted_attributes   
    rendered_attributes.each do |header_attribute|
      
      if fi.form.is_rendered(header_attribute)
      
        s += create_field_label(header_attribute , t(header_attribute), 'f_')
        s += "<tr><td>"
        if header_attribute.to_s.downcase() == "product_form_nickname"
          s += '<input name="' + fi.form.get_html_form_field(header_attribute.to_s) + '" value="' + fi.form.get_form_custom_name(fi.language_id).to_s + '" size="33"/>'
        else       
          s += '<'
          s += fi.form.get_html_tag(header_attribute.to_s)
          s += ' name="' + fi.form.get_html_form_field(header_attribute.to_s) + '"'
          s += ' value="' + fi.form.attributes[header_attribute.to_s].to_s + '"'
          s += fi.form.get_html_residue (header_attribute.to_s)
          s += ' size="33"/>'
          if fi.form.has_inner_value(header_attribute.to_s)
            s += fi.form.attributes[header_attribute].to_s            
          end
          
          s += '</' + fi.form.get_html_tag(header_attribute.to_s) + '>'          
        end
    
        s += "</td></tr></table>"
      end
    end
    
    
    
    #create the toolbar
    s += "<div id='toolbar' class='ui-widget-header ui-corner-all'>"
    s += " <input type='submit' onclick='edit_form(this);' value='" + t(:enable_edit) + "' name='enable_edit' size='30'>"
    s += " <input type='submit' onclick='validate_and_submit();' type='submit' value='" + t(:save_changes) + "' name='save_header'>"
    s += " <input id='button' type='reset' value='" + t(:reset_changes) + "'>"
    s += "</div>"    

    s += "</p>"
    
    return s
    
  end

  def write_tab_link(i, l)
      return '<li><a href="#tabs-' + i.to_s + '">' + (l.language_description) + '</a></li>'	
  end

  def render_formplate(fi)
    s = ""
    if fi == nil
      return "error"
    else
      
      
      s += '<table border="0" cellspacing="0" cellspacing="0"><tr>'  
        #to render the formplate, we want to render elements within the formplate
        fi.formplate.form_elements.each do |e|  
          if e.is_new_line
              s += "</tr></table></td></tr><tr><td><table><tr>"
          else
            s += '<td align="left">'
            s += create_element(e, fi)
            s += "</td>"
          end          
        end
      
      
      s += "</tr><tr><td>"
      s += "<div id='toolbar' class='ui-widget-header ui-corner-all'>"
      s += "<input type='submit' id='submit' onclick='validate_and_submit()' value='" + raw(t(:save)) + "' name='commit'>"
      s += "<input type='submit' id='submit' onclick='validate_and_submit()' value='" + raw(t(:save_as_new_version))  + "' name='newversion'>"
      s += "<input type='submit' id='submit' onclick='save_or_discard()' value='" + raw(t(:history))  + "' name='history'>"      
      s += "<input type='submit' id='submit' onclick='save_or_discard()' value='" + raw(t(:print_draft))  + "' name='print_draft'>"      
      s += "<input type='submit' id='submit' onclick='save_or_discard()' value='" + raw(t(:flag_for_review))  + "' name='flag_for_review'>"      
      s += "<input type='reset' value='" + raw(t(:reset_changes)) +"'>"
      s += "</div></td>"
      

      s += "</tr></table>"
      
      return s
    end
  end

  def render_custom_contents(fi)
    return "html for custom content goes here"
  end
  
  def create_element(e, fi)
    #e is the element we are creating right now
    #fi is the form_instance which is being rendered right now
    
      
    #we will generate the html and put it in the variable s, so initialize s w/ an empty string
    s = ''
      
      
    #if e is nil, then we dont need to generate anything. this may happen from time to time, if there are empty records in the database       
    if e == nil
      return s
    end

    #if e's elementtype does not exist in the database then don't generate anything.  
    if e.element_type == nil
      return ""
    end
    
    
    #encapsulate the element within its own table for structure
    s = '<table cellspacing="0" cellpadding="0" border="0" align="left">'
        


    #--------------Generate a caption for the HTML Control (where applicable) ------------->

    #if the element's type is one of those type that displays caption, then display a caption
    if e.element_type.has_caption
      s+= '<tr><td colspan="2" align="left">'
      s+= '<h4 class="formplate_caption" align="left">'
      s+= e.get_caption(current_language_id).to_s
      s+= ' '
      s+= '</h4>'
      s+="</td></tr>"
    end
    
    #--------------------------------------------------------->
    
    
    
    
    #-----------------Code block to look up the current value (this would be the most recent value, or default value------->)
    
    #v is the value for this element. if the value doesnot exist, then put a default value. if default value doesnt exist then leave it empty
    v= e.get_value(fi)
    if v == nil
      v = e.default_value.to_s
    end
    
    #----------------------------code block ends --------------------------------------------->



    #----------------------------------------- Rendering, and checking for validation error --------------->
    res = is_object_invalid(e.id.to_s,'e')
    
    if res 
         inv_msg = e.get_invalid_message(fi.language.id)
         s+= "<tr><td class='alert alert-failure' colspan='2'>"
         
         if inv_msg.empty?
          s += t(:invalid_entry) 
         else
          s+= e.get_invalid_message(fi.language.id)
         end
         
         
         s+= "</td></tr>"
    end
        
    
    #--------------------------------------------------------validation check during rendering end----------->
    
    #-------------generate the actual HTML Control Heere -------------->
    #---from up above, this block of code needs:
    #----------v (this is the value to start the page with)
    #----------e (this is the element we are generating)
    #----------s which is the runnning collection of the HTML content
    #
    #
    
    s+='<tr><td valign="top" width="1"></td><td><' + e.get_html_tag.to_s
          
    #determine name for this element
    s+= ' id="i' + e.id.to_s + '" name="e' + e.id.to_s + '" '             
  
    #if the current version is not editable then disable the field
    if @current_version.is_edit_able == false
      s+= " disabled "
    end
    
  
      
    #there are two types of HTML elements - one that uses 'value' attribute to store the value (ex: Input .. value = xyz), and the other
    #---the other encapsulates the value betw the open an closing tags of the HTML element.
    #---the element_type.has_inner_value_type = true boolean tells us that it encapuslates the value betw HTML open and close tags (ex: TextArea)
    if e.element_type.has_inner_value_type
            s+=">" + v
    else
            s+=" value='" + v + "'>"
    end


    if e.is_list
      l = e.get_list
        if l != nil
          #this helper method works for normal arrays, but not for hash
          s += options_for_select(l, v)          
        end
    end

    s+= e.element_type.html_close_tag
    
    #--------------------HTML control generation code end -------------->
  



 
    
    #finish encapsulation within the table
    s+="</td></tr></table>"
      
    return s  
    
  end
  
  def create_field_label(obj, lbl, obj_type)
   s = '<table cellspacing="2" cellpadding="2" border="0" align="left">'
   s += "<tr><td colspan='2'><b>" + label_tag(obj, lbl) + "</b></td></tr>"
   
   if is_object_invalid(obj, obj_type)
     s += "<tr><td class='alert alert-failure'>" + t(:invalid_entry) + "</td></tr>"
   end

   return s  

  end
  
  def close_field_tag
    return "</table>"
  end
  
  
  
  
  def is_object_invalid(obj_id, suffx)
    ###if this is a redirect from a form postback. The @invalid_elements has will contain all the objects
    ###----whose validations failed. So this method will check to see if the obj is valid or not. the variable
    ###----suffx idenfies the suffix before the id to differentiate between form (f) and element (none)
     
     
    if params['test']== nil
      params['test'] = ' '
    end
    
    params['test'] +=  suffx + obj_id.to_s + ";"
      
    if @invalid_elements == nil
      return false
    else
      return @invalid_elements.include?(suffx + obj_id.to_s)
    end
    
      
  end

end #end module
  
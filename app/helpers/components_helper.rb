module ComponentsHelper

# write_component builds an html string to be output showing all the 
# components on a product.
#
# c = component
# bi = product instance

  def write_component (c, bi, accordionCounter)
        s =''
	if c != nil
            
	    c.literals.each do |l|

      s += "<div class='bodyIcon'>" + image_tag(c.icon_url, :size => "75x75")
      
      s += "<a class='accordion-toggle' data-toggle='collapse' data-parent='#accordion2' href='#collapse#{accordionCounter}'>"
		  s += "#{l.literal.html_safe}</a>"
      
	    end
	    
	    s +=  '[' + c.component_type.component_type_description + ']' + "</div></div>"
 
	    s += "<div id=collapse#{accordionCounter} class='accordion-body collapse'>"
      s += "<div class = 'accordion-inner'>"

	    s += write_formplates(c, @product_instance)
	    
	    if c.sub_components.nil?
	 else
              s += "<ul class='sub_components'>"
                  c.sub_components.each do |sub|
                    s+=write_sub_component(sub.component, bi)
                  end
              s += "</ul>"
	 end
	s += "</div></div>"
  end
	return s.html_safe
    end
    
    def write_formplates (c, bi)
      g = "<ul class='formplates'>"      
      c.component_formplates.each do |f|
        g += "<li>"
        if bi == nil
          g += link_to f.formplate.title, f.formplate
        else
          p = bi.get_form(f.formplate)
          if p == nil?
              g += link_to f.formplate.title, f.formplate
          else
              g += link_to f.formplate.title, p             
          end
        end
        g += "</li>"
      end
      g += "</ul>"
      
      return g
    end  
end

def write_sub_component (c, bi)
  s =''
  if c != nil
            
      c.literals.each do |l|

      #s += link_to(l.literal.html_safe, product_type_product_instance_component_path(params[:product_type_id], bi, c)).html_safe + '(' + l.language.language_description + ') | ' 
      s += l.literal.html_safe +  '(' + l.language.language_description + ') | '
      end
      
      s +=  '[' + c.component_type.component_type_description + ']'
 
     

      s += write_formplates(c, @product_instance)
      
      if c.sub_components.nil?
   else
              s += "<ul class='sub_components'>"
                  c.sub_components.each do |sub|
                    s+=write_sub_component(sub.component, bi)
                  end
              s += "</ul>"
   end
  
  end
  return s.html_safe
    end

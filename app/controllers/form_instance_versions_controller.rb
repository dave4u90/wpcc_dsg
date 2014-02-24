class FormInstanceVersionsController < ApplicationController
  def show
    
    @form_instance_version = FormInstanceVersion.find (params[:id])
    @form_instance = @form_instance_version.form_instance
    @form = @form_instance.form
    
    ###since form_instance_version is read-only - the show view will just generate a pdf
    ##this would come in handy when we want to publish a document...just redirect to this view.    
    
    Prawn::Document.generate("explicit.pdf") do |pdf|
      ###generate pdf text of how the version should appear
      ###how to generate a nice pdf is here: http://prawn.majesticseacreature.com/manual.pdf   
      
      
      #--------------------PDF Header---------------
      pdf.font_size(14)
      pdf.text @form.get_title
      pdf.horizontal_rule
      #-----------------------PDF Body--------------
      
      @form_instance.formplate.form_elements.each do |element|
        if element.element_type == nil
        else
          if element.element_type.has_caption         
            pdf.font "Helvetica", :style => :bold
            pdf.text element.caption
            pdf.font "Helvetica"
            value = @form_instance_version.get_element_value(element.id)
            if value == nil
              value = "emptyline"
            end
            
            pdf.text value
          end
        end        
      end
      
      pdf.horizontal_rule
      #------------------------PDF Footer-----------
      
      ######
      send_data pdf.render,  :filename => @form_instance_version.pdf_file_name + ".pdf", :type => "application/pdf"
    end
    
    
      
  end
end

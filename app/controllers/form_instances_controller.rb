class FormInstancesController < ApplicationController
  def update
    

  end
  
  def show
    @form_instance = FormInstance.find(params[:id])
    
  end      
end

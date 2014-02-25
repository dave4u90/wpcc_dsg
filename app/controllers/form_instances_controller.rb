class FormInstancesController < ApplicationController
  before_filter :login_required

  def update


  end

  def show
    @form_instance = FormInstance.find(params[:id])

  end
end

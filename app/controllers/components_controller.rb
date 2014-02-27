class ComponentsController < ApplicationController
  before_filter :login_required, only: [:show]

  def index
    @components = Component.all
    render 'show'
  end

  def show
    @component = Component.find(params[:id])
    @product_instance = ProductInstance.find(params[:product_instance_id])
    #raise @product_instance.to_yaml
    @new_component = Component.new
  end

  def create
    @sub_component = Component.new(params[:component])

    #artificially assign a title to the componet comprised of its literals
    @sub_component.component_description = @sub_component.artificial_title
    @sub_component.save


    #save and then redirect to the show page of the parent component
    if @sub_component.save
      flash[:success] = t(:successfully_created)
      redirect_to Component.find(@sub_component.parent_component_id)
    else
      flash[:error] = t(:error_created)
      redirect_to Component.find(@sub_component.parent_component_id)
    end

  end

end

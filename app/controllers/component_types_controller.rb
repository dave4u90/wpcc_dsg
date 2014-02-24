class ComponentTypesController < ApplicationController
  
	def index
		@component_types = ComponentType.paginate(page: params[:page])
	end

	def show
  	@component_type = ComponentType.find(params[:id])
  	@components = Component.find_all_by_component_type_id(params[:id]) 
	end

end

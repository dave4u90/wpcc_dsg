class ProductTypesController < ApplicationController
  def index
    		@product_types = ProductType.paginate(page: params[:page])

  end

  def new
  end

  def edit
  end
  
  def show
    	@product_type = ProductType.find(params[:id])
  end
end

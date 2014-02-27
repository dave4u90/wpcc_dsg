class ProductTypesController < ApplicationController
  before_filter :login_required
  before_filter :only_talott_required, only: [:edit]

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

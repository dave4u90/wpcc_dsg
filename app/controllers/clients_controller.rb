class ClientsController < ApplicationController
  before_filter :login_required, only: [:show]

  def index
    @clients = Client.all
  end

  def show
    client = Client.find(params[:id])
  end

  def new
    @client = Client.new
    @client.build_address
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      flash[:success] = "Company Updated"
      redirect_to @client
    else
      render 'new'
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      flash[:notice] = "Successfully updated client"
      redirect_to root_path
    else
      render :edit
    end
  end

end

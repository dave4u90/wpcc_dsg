class ClientsController < ApplicationController
  before_filter :login_required, only: [:show]
  before_filter :only_admin_allowed, only: [:edit]

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

end

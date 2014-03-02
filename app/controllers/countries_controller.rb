class CountriesController < ApplicationController
  before_filter :login_required, except: [:show, :index]

  def new
  end

  def show
    @my_id = params[:id]
    if is_number?(@my_id.to_s)
      @country = Country.find(@my_id)
    else
      @countries = Country.where ("name LiKE '" + @my_id.to_s + "'")
      if @countries.empty?
      else
        @country = @countries.first
      end
    end

    if @country
      @states = @country.states
    else
      @states = nil
    end


    render 'show', :layout => false
  end


  def index
    @countries = Country.all
    render 'index', :layout => false
  end

end

class CityController < ApplicationController
  def index()
    @cities = Cities.all
    render 'index', :layout => false
  end
end

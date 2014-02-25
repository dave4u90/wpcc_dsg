class CityController < ApplicationController
  before_filter :login_required
  def index()
    @cities = Cities.all
    render 'index', :layout => false
  end
end

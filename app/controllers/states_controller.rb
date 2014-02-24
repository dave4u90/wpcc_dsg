class StatesController < ApplicationController
  responds_to :json
  
  
  def new
  end

  def index
      @states = State.where(:country_id => params[:country_id])
      respond_with(@states)
  end
  
  def states()
    @country = Country.find(params[:id])
    if @country
      @states  = @country.states
    end
    render @states.to_json
  end


  
end

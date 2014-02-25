class FormplatesController < ApplicationController
  before_filter :login_required

  def index
    @formplates = Formplate.all
  end

  def show
    @formplate = Formplate.find(params[:id])
  end


end

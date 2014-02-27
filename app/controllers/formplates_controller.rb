class FormplatesController < ApplicationController
  before_filter :login_required
  before_filter :only_talott_allowed, only: [:edit]

  def index
    @formplates = Formplate.all
  end

  def show
    @formplate = Formplate.find(params[:id])
  end


end

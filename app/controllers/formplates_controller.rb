class FormplatesController < ApplicationController
	def index
		@formplates = Formplate.all
	end

	def show
		@formplate = Formplate.find(params[:id])
	end


end

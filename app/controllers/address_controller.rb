class AddressController < ApplicationController
	def new
		@address = Address.new
	end

	def create
		@address = Address.new(params[:address])
		if @address.save
	      		flash[:success] = "Address Updated"
  			
	  	else
	  		render 'new'
	  	end

	end
	
	def index()
		@addresses = Address.all
		@new_address = Address.new
	end

end

class ProductsController < ApplicationController

	def new
		@product = Product.new 
	end

	def create
			bparams = params[:product]
			new_products_added = bparams[:number_of_products].to_i
			product_type_id = bparams[:product_type_id]
			new_products_added.times do |index |
				product = Product.new
				product.assign_registration_key
				product.product_type_id = product_type_id
				product.save 
				flash[:success] = "#{new_products_added}, new products added"
				redirect_to new_product_path 
    end 
  end
  
end



class ProductInstancesController < ApplicationController

	
	def index
		#Filter product instances to only show those the client has access to
		if params[:product_type_id]
			@product_type = ProductType.find(params[:product_type_id])
			@product_instances = @product_type.product_instances.find_all_by_client_id(current_user.client_id)
		else
			@product_instances = ProductInstance.find_all_by_client_id(current_user.client_id)
			
			@product_instances.each do |d|
			  logger.info d.inspect
			end
		end 
	end 

	def show
		@product_instance  = ProductInstance.find(params[:id])
	end

	def new
		@product_instance = ProductInstance.new

		@client_id = params[:client_id]
		@user_id = params[:user_id]
		if @client_id
			@client = Client.find(@client_id)
		end
		if @user_id
			@user = User.find(@user_id)
		end
				
		@product_key = params[:key]
		@product_key_object = ProductKey.find_by_product_key(@product_key)
		
		if @product_key_object == nil
			flash[:error] = t(:enter_registration_key_without_hyphen)
			redirect_to validate_key_path(:method => :product, :user_id => @user_id, :client_id => @client_id)
		end	

		@product_type_id = @product_key_object.product_type_id

		@from= params[:from]
		@user = User.new
		@address = @product_instance.build_address
		if @client
			@product_instance.client_id = @client.id
		else
			@client = @product_instance.build_client
			@client_address = @client.build_address			
		end
		if @user
			@user_access = @product_instance.user_accesses.new
			@user_access.user_id = @user_id
			@user_access.access_role_id = AccessRole.get_administrator_id
		end
		
	end 

	def edit
		@product = ProductInstance.find(params[:id])
		
	end

	def create
		#step1 user submits the key
		#using ProductKey model check to see if key is valid
		#if key is valid - check to make sure product is not in use (can not register an already registered key)
		#render new and show new product instance fields in the view.
		
		#step 2 user submits product_instance items
		#validate and save them in the database
		#render user.new with this product_key
		
		
		
		
		
		#----load all the variables 
		@product_key = params[:key]
		@product_instance = ProductInstance.new(params[:product_instance])
				
		
		@client_id = params[:client_id]
		@user_id = params[:user_id]
		if @client_id
			@client = Client.find(@client_id)
		end
		if @user_id
			@user = User.find(@user_id)
			if @user
				@user_access = @product_instance.user_accesses.first
				@user_access.user_id = @user_id
				@user_access.access_role_id = AccessRole.get_administrator_id
			end
		end
		
		@product_key = params[:key]
		@product_key_object = ProductKey.find_by_product_key(@product_key)
		
		@product_type_id = @product_key_object.product_type_id




		
		#if param[same_as_above] is there then it means its just a clcik on same as above
		if params['same_as_above']
			#set client address = values from pi.address and render new
			if @product_instance.client
				if @product_instance.client.address && @product_instance.address
					@product_instance.client.address.fill(@product_instance.address)
					@same_as_above = true
				end			
			end
			
			render 'new'
			return
		end
		








                #create process starts here --->

		k_msg =  t(:product_registered_successfully, :link => (view_context.link_to t(:click_here), product_instances_path(@product_instance)) )
		if @product_instance.save
			UserMailer.signator_new_product_registration_email(@product_instance).deliver
			flash[:success]= k_msg
			if current_user
				redirect_to ProductInstance
			else
				redirect_to root_path
			end 
		else
		        render 'new'
		end
		   		
		
	end

	def update
		@product_instance = ProductInstance.find(params[:id])
		
		#this is a mechanism to ensure last standing admin doesnt get suspended. Start off as if
		#we are ok for admincheck
		admin_check = false

		
		if params["save_product"] != ""
			@msg = "we have to save the product info<br>"

			#save all attributes for the product
			#---go thru the attributes for product_instance, except id, if there is anything left
			@product_instance.attributes.each do |attrib|
				#if params.contains(attrib)
					@msg += attrib.to_s + "=" + params[attrib].to_s +  "<br>"
				#end
				
			end
			
			#then save the meta-data
			
			
			
		end
		
		#check which UA to remove
		remove_ua = params[:ua]
		if remove_ua != nil
			my_ua = UserAccess.find (remove_ua)
			
			res = my_ua.remove_access
			
			if res
				@msg = t(:successfully_updated_user)
			else
				@msg = t(:cannot_delete_the_only_administrator)
			end
		end
		
		#check which UA to remove
		suspended_user = params["suspend_user"]
		if suspended_user != nil
			my_user = User.find (suspended_user)
			res = my_user.suspend_user(@product_instance)
			
			if res
				@msg = t(:successfully_updated_user)
			else
				@msg = t(:cannot_suspend_the_only_administrator)
			end
		end

		authorized_user = params["authorize_user"]
		if authorized_user != nil
			my_user = User.find (authorized_user)		

			my_user.update_attribute "is_active", true
			my_user.save
			@msg = t(:successfully_updated_user)
		end
		
		
		#make administrator
		make_admin_user = params["make_admin"]
		if make_admin_user != nil
			my_user = User.find (make_admin_user)
			if my_user.is_administrator (@product_instance)
				@msg = t(:already_administrator)
			else
				@product_instance.add_administrator_role my_user
				@msg = t(:successfully_updated_user)
			end			
		end
		
		#make regular
		make_regular_user = params["make_regular"]
		if make_regular_user != nil
			my_user = User.find (make_regular_user)
			if my_user.is_administrator (@product_instance)
				res = (@product_instance.remove_administrator_role my_user)
				if res
					@msg = t(:successfully_updated_user)
				else
					@msg = t(:cannot_delete_the_only_administrator)
				end
				
			else				
				@msg = t(:not_an_administrator)
			end			
		end
		
	end
	      
      
      
	def request_initial 
	 
		if ProductInstance.is_valid_key(params[:reg_key])
			if ProductInstance.key_in_use(params[:reg_key]) == false  	   
			        flash[:error] = t('key_not_found')
				redirect_to new_product_instance_path(:method => 'initial')
			else
				flash[:success] = t('valid_key')
				redirect_to new_product_instance_path(key: params[:reg_key], from: params[:from])
			end
		else
			flash[:error] = t('key_not_found')
			redirect_to new_product_instance_path(:method => 'initial')
		end
	   
	end
	
	
	def authorize_user()
		authorized_user = params["user_id"]
		if authorized_user != nil
			my_user = User.find (authorized_user)		
		
			my_user.update_attribute "is_active", true
			my_user.save
			@msg = t(:successfully_updated_user)
		end
	end
		
	def notify_signator()
		product_instance_id = params[:id]
		if product_instance_id
			@product_instance = ProductInstance.find(product_instance_id)
			if @product_instance
#				UserMailer.signator_new_product_registration_email(@product_instance).deliver
				flash[:success] = t(:email_sent_successfully)
				redirect_to product_instances_path
			end
		else
			flash[:error] = t(:unidentified_error)
			redirect_to product_instances_path
		end
		
	end
	
	
	def copy_pi_address_to_client()
		@pi = ProductInstance.new(params[:product_instance])
		render :js => 'alert(' + @pi.address.line1.to_s + ')'
	end
end

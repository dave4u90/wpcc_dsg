class ProductInstancesController < ApplicationController
  include ActionView::Helpers::JavaScriptHelper
  before_filter :login_required, only: [:index, :show, :edit, :update]
  #before_filter :only_admin_allowed, only: [:edit]


  def index
    #Filter product instances to only show those the client has access to
    if current_user.present?
      if params[:product_type_id]
        @product_type = ProductType.find(params[:product_type_id])
        @product_instances = @product_type.product_instances.find_all_by_client_id(current_user.client_id)
      else
        @product_instances = ProductInstance.find_all_by_client_id(current_user.client_id)
        @product_instances.each do |d|
          logger.info d.inspect
        end
      end
    else
      flash[:notice] = "Please login to continue"
      redirect_to root_path
    end
  end

  def show
    @product_instance = ProductInstance.find(params[:id])
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
    @address = Address.new(params[:product_instance][:address])
    product_instance_params = params[:product_instance]
    product_instance_params.delete(:address)
    @product_instance = ProductInstance.new(product_instance_params)
    if @product_instance.valid?
      @address.save
      @product_instance.address = @address
      @product_instance.save
      product_key = ProductKey.find_by_product_key(@product_instance.product_key)
      product_key.update_attributes(product_instance_id: @product_instance.id)
      UserMailer.signator_new_product_registration_email(@product_instance).deliver
      @client = @product_instance.client || @product_instance.build_client
      @client.attachments.build
      @user = User.find_by_id(params[:user_id])
      if @user.present?
        @user_access = @product_instance.user_accesses.first || @product_instance.user_accesses.build
        @user_access.user_id = params[:user_id]
        @user_access.access_role_id = AccessRole.get_administrator_id
      end
      @product_form_object = ActionView::Helpers::FormBuilder.new(:product_instance, @product_instance, ActionView::Base.new(@product_instance), {:remote => true}, proc { |f|})
      binded_html = render_to_body(:file => "#{Rails.root}/app/views/product_instances/_client_form.html.erb")
      render :js => "show_client_register_form('#{ escape_javascript binded_html}')" and return
    else
      @object = @product_instance
      binded_html = render_to_body(:file => "#{Rails.root}/app/views/product_instances/_product_instance_errors.html.erb")
      render :js => "$('#product_instance_errors').html('#{ escape_javascript binded_html}')" and return
    end
  end

  def create_client
    @product_instance = ProductInstance.find(params[:id])
    @user_access = @product_instance.user_accesses.first || @product_instance.user_accesses.build
    @client = @product_instance.client || @product_instance.build_client
    @address = @client.new_record? ? @client.build_address : @client.address
    client_params = params[:product_instance][:client]
    address_attributes = params[:product_instance][:client].present? ? params[:product_instance][:client][:address_attributes] : Hash.new
    client_params.delete(:address_attributes) if @client.new_record?

    if @client.new_record?
      if @client.update_attributes(client_params)
        @product_instance.update_attributes(:client_id => @client.id)
        if @user_access.update_attributes(params[:product_instance][:user_accesses])
          if @address.update_attributes(address_attributes)
            if current_user.present?
              flash[:notice] = "Product has been successfully registered"
              flash.keep(:notice)
              render :js => "window.location.replace('#{root_url}')" and return
            else
              @user = User.new
              @address = @user.build_address
              @product_key = @product_instance.product_key
              binded_html = render_to_body(:file => "#{Rails.root}/app/views/users/_new.html.erb")
              render js: "show_user_register_form('#{escape_javascript binded_html}');" and return
            end
          else
            @object = @address
            binded_html = render_to_body(:file => "#{Rails.root}/app/views/product_instances/_product_instance_errors.html.erb")
            render :js => "$('#client_errors').html('#{ escape_javascript binded_html}')" and return
          end
        else
          @object = @user_access
          binded_html = render_to_body(:file => "#{Rails.root}/app/views/product_instances/_product_instance_errors.html.erb")
          render :js => "$('#client_errors').html('#{ escape_javascript binded_html}')" and return
        end
      else
        @object = @client
        binded_html = render_to_body(:file => "#{Rails.root}/app/views/product_instances/_product_instance_errors.html.erb")
        render :js => "$('#client_errors').html('#{ escape_javascript binded_html}')" and return
      end
    else
      if @user_access.new_record?
        if @user_access.update_attributes(params[:product_instance][:user_accesses])
          success_message = t(:product_registered_successfully, :link => (view_context.link_to t(:click_here), product_instances_path(@product_instance)))
          flash[:notice] = success_message
          flash.keep(:notice)
          render :js => "window.location.replace('#{product_instances_url}')" and return
        else
          @object = @user_access
          binded_html = render_to_body(:file => "#{Rails.root}/app/views/product_instances/_product_instance_errors.html.erb")
          render :js => "$('#client_errors').html('#{ escape_javascript binded_html}')" and return
        end
      end
    end
  end

  def create_user
    @user = User.new(params[:user])
    product_key = params[:product_key]
    @product_instance = ProductInstance.find(params[:user][:product_instance_id])
    if @user.valid?
      @user_access = @user.user_accesses.build(:product_instance_id => @product_instance.id, :access_role_id => AccessRole.get_administrator_id)
      find_other_users = User.where(client_id: @user.client_id)
      @user.is_active = true unless find_other_users.present?
      @user.save
      UserMailer.send_reg_email(@user).deliver
      flash[:notice] = "You have successfully registered."
      flash.keep(:notice)
      render :js => "window.location.replace('#{sucess_user_url}')" and return
    else
      @object = @user
      binded_html = render_to_body(:file => "#{Rails.root}/app/views/product_instances/_product_instance_errors.html.erb")
      render :js => "$('#user_errors').html('#{escape_javascript binded_html}')" and return
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
        @msg += attrib.to_s + "=" + params[attrib].to_s + "<br>"
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
#       UserMailer.signator_new_product_registration_email(@product_instance).deliver
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

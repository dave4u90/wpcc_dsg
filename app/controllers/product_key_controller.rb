class ProductKeyController < ApplicationController
  include ActionView::Helpers::JavaScriptHelper
  before_filter :login_required, except: [:validate_key, :post_validate_key, :validate_key_for_product]

  def index()
    @keys = ProductKey.all
  end

  def validate_key()
    @product_instance = ProductInstance.new
    @method = params[:method]
    if @method == nil
      @method = :user
    end
    @user_id = params[:user_id]
    if @user_id
      @user = User.find(@user_id)
    end
    if @user
      @client_id = @user.client.id.to_s
    end
  end


  def post_validate_key ()
    method = params[:method]
    if method == 'user'
      validate_key_for_user(params[:reg_key])
    elsif method == "product"
      if current_user.present?
        validate_key_for_product(params[:reg_key], params[:user_id], params[:client_id])
      else
        flash[:notice] = "Please log in to continue"
        redirect_to root_path
      end
    end
  end

  def validate_key_for_user(key)
    if ProductKey.valid_key(key)
      if ProductKey.key_in_use(key)
        @user = User.new
        @product_instance = ProductInstance.where(product_key: key).first
        @client = @product_instance.client
        @product_key = key
        @address = @user.build_address
        binded_html = render_to_body(:file => "#{Rails.root}/app/views/users/_new.html.erb")
        render :js => "show_user_register_form('#{escape_javascript binded_html}');" and return
      else
        @product_instance = ProductInstance.new
        @address = Address.new
        @product_key = key
        @user_id = nil
        @client_id = nil
        @user = User.new
        @product_type_id = ProductKey.select([:product_key, :product_type_id]).where(product_key: key).first.try(:product_type_id)
        @client = Client.new
        binded_html = render_to_body(:file => "#{Rails.root}/app/views/product_instances/_new.html.erb")
        render :js => "show_product_register_form('#{ escape_javascript binded_html}');"
      end
    else
      render :js => "$('#invalid_key_error').show();"
    end
  end

  def validate_key_for_product(key, user_id, client_id)
    if ProductKey.valid_key(key)
      if ProductKey.key_in_use(key)
        render :js => "$('#key_in_use_error').show();"
      else
        @product_instance = ProductInstance.new
        @address = Address.new
        @product_key = key
        @user_id = user_id
        @client_id = client_id
        @user = User.find(user_id)
        @product_type_id = ProductKey.select([:product_key, :product_type_id]).where(product_key: key).first.try(:product_type_id)
        @client = Client.find(client_id)
        binded_html = render_to_body(:file => "#{Rails.root}/app/views/product_instances/_new.html.erb")
        render :js => "show_product_register_form('#{ escape_javascript binded_html}');" and return
        #redirect_to new_product_instance_path :key => ProductKey.clean_key(@key), :reg_key => ProductKey.clean_key(@key), :client_id => @client_id, :user_id => @user_id and return
      end
    else
      render :js => "$('#invalid_key_error').show();"
    end
  end

end

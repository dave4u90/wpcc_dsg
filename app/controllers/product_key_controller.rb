class ProductKeyController < ApplicationController
  def index()
    @keys = ProductKey.all
  end
  
  def validate_key()
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
    @method = params[:method]
    
    #if method is product then validate_key_for_product
    if @method == 'user'
      redirect_to (new_user_path :key => ProductKey.clean_key(params[:reg_key])) and return
    else
      validate_key_for_product()
    end
    
  end
  
  def validate_key_for_product()
    #key must be valid and not in use
    raise params[:key].to_s
    @key = params[:key]
    @client_id = ""
    @user_id = ""
    
    @client_id = params[:client_id]
    @user_id = params[:user_id]
    
    if ProductKey.valid_key(@key)
      if ProductKey.key_in_use(@key)
        flash[:notice] = t(:key_in_use_error)
        render 'validate_key' and return
      else
        redirect_to new_product_instance_path :key=> ProductKey.clean_key(@key), :reg_key => ProductKey.clean_key(@key), :client_id => @client_id, :user_id => @user_id and return
      end
    else
      flash[:notice] = t(:invalid_key_error)
      render 'validate_key' and return
    end       
  end
  
end

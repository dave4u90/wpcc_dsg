class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def index
    @users = User.find_all_by_client_id(current_user.client_id)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @product_key = params[:key]
    @product_instance = ProductInstance.find_by_product_key(params[:key]) if params[:key]


    if @product_instance == nil
      flash[:notice] = t(:invalid_key)
      redirect_to "/product_key/validate_key" and return
    else
      @user = User.new
      @user.client_id = @product_instance.client_id
      @user.build_address (@product_instance.address.my_updatable_attributes)
    end
  end

  def edit
  end

  def create
    #raise params.inspect
    @user = User.new(params[:user])
    biparams = params[:user]


    if @user.valid?
      #UserMailer.send_reg_email(User.first).deliver
      #redirect_to sucess_user_path(:value=>true)
      UserMailer.send_reg_email(@user).deliver

      #add user access to this product_instance from the key
      @user.add_product_instance_access(params[:product_key])

      if @user.save

        @product_key = params[:key]
        @product_instance = ProductInstance.find_by_product_key(@product_key) if (@product_key)


        #now add user access
        @user.create_default_user_access(@product_instance)

        redirect_to sucess_user_path(:value => true)

      else
        ##fj comment: need to pass ':key' and ':method' from the previous page

        @product_key = params[:key]
        @product_instance = ProductInstance.find_by_product_key(@product_key) if (@product_key)


        render 'new'
      end
    else
      @product_key = params[:key]
      @product_instance = ProductInstance.find_by_product_key(@product_key) if (@product_key)


      render 'new'
    end
  end


  def email_confirmation
    @user = User.find_by_email(params[:email])
    @user.update_attribute :email_confirmed, true
    @user.save
    change_locale params[:locale]
    redirect_to (root_path :locale => params[:locale]), :notice => t(:email_verified)
  end

  def current_user_request_access()
    @user = User.find(params[:user_id])
    @product_instance = ProductInstance.find (params[:product_instance_id])

    if @user && @product_instance
      UserMailer.request_access @user, @product_instance
    end

    flash[:success] = t(:request_sent)
    redirect_to :back
  end


  def sucess
    #redirect_to root_url unless params[:value] == true
    logger.info "((((((((((((()))))))))))))"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Your profile was updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def send_confirmation_email()
    @email = params[:email]
    if @email
      @user = User.find_by_email(@email)
      if @user
        UserMailer.send_reg_email(@user).deliver
        flash[:success] = t(:validation_email_was_sent, :email => @email)
      else
        flash[:error] = t(:no_user_found, :email => @email)
      end
      redirect_to :back
    else
      redirect_to :back
    end

  end

  def request_access
    if ProductKey.key_in_use(params[:reg_key])
      product_key = ProductInstance.product_instance_by_key(params[:reg_key])
      params[:product_key_is_nil] = product_key.nil?
      if product_key != nil
        #flash[:success] = t('valid_key')
        redirect_to new_user_path(key: params[:reg_key])
      else
        flash[:error] = t('key_not_found')
        redirect_to new_user_path(:method => 'request_access')
      end
    else
      flash[:error] = t('key_not_found')
      redirect_to new_user_path(:method => 'request_access')
    end

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in"
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end

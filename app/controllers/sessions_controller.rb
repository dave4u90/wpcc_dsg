class SessionsController < ApplicationController

  def new
    if current_user
      flash[:notice] = "You are already signed in."
      redirect_to product_instances_path and return
    end
  end

  def create
    @email = params[:session][:email]
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if params[:remember_me]
        cookies.permanent[:remember_token] = user.remember_token
      else
        cookies[:remember_token] = user.remember_token
      end
      if user.email_confirmed == false
        render :js => "email='" + @email + "'; hide_error_messages(); $('#email_not_confirmed_error_div').show()"
        return
      end

      if user.is_active == false
        render :js => "hide_error_messages(); $('#access_pending_error_div').show()"
        return
      end


      sign_in user
      session[:locale] = current_user.locale

      @redirect_path = "/product_instances/?locale="+params[:locale]
      flash[:notice] = "Welcome #{user.name}."
      logger.info @redirect_path
    else
      render 'new', :js => "hide_error_messages(); $('#sign_in_error_div').show()"
      return
    end
  end

  def destroy
    sign_out
    cookies.delete(:remember_token)
    flash[:notice] = "You have been logged out successfully."
    redirect_to root_path and return
  end


end

class PasswordResetsController < ApplicationController
  before_filter :login_required

  def new
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def create
    user = User.find_by_email(params[:email])
#  	
    if user
      user.send_password_reset

      flash[:success] = t(:password_reset_instructions_sent)
      @redirect_path = root_path

    else
      render :js => "hide_error_messages(); $('#error_div').show()"
    end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])


    if @user == nil
      flash[:error] = t(:password_could_not_be_reset)
      redirect_to root_path
    end

    if @user.password_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => t(:password_expired)
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => t(:password_reset_successful)
    else
      render :edit
    end

  end


end

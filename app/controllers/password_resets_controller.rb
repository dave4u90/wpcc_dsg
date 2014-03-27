class PasswordResetsController < ApplicationController
  before_filter :login_required, except: [:new, :create, :edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def create
    @user = User.find_by_email(params[:email]) || User.new
    if verify_recaptcha(:model => @user, :message => "Please enter correct captcha values.")
      if @user.present? and !@user.new_record?
        @user.check_password = false
        @user.send_password_reset
        flash[:success] = t(:password_reset_instructions_sent)
        redirect_to root_path
      else
        @user.new_record? ? (@user.errors.clear and @user.errors.add(:base, t(:email_address_not_found))) : @user.errors.add(:base, t(:email_address_not_found))
        render :new
      end
    else
      if @user.new_record?
        @user.errors.clear
        @user.errors.add(:base, t(:email_address_not_found))
        @user.errors.add(:base, "Please enter correct captcha values.")
      end
      render :new
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

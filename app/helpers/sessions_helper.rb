module SessionsHelper

  def sign_in(user)
    current_user = user
    session[:user_id] = user.try(:id)
  end

  def signed_in?
    current_user.present? and session[:user_id].present?
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end

  def current_user
    @current_user = nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= User.where(remember_token: cookies[:remember_token]).first if cookies[:remember_token]
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user = nil
    session[:user_id] = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def only_admin_allowed
    unless current_user.admin
      flash[:notice] = "Only for administrator. You are not allowed to access that page."
      redirect_to "/"
    end
  end

  def only_talott_allowed
    unless current_user.is_tallot
      flash[:notice] = "Only for talott user. You are not allowed to access that page."
      redirect_to "/"
    end
  end

  def login_required
    unless signed_in?
      flash[:notice] = "Please log in to continue"
      redirect_to "/"
    end
  end
end

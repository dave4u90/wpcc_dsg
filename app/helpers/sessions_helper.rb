module SessionsHelper

  def sign_in(user)
    current_user = user
    session[:user_id] = user.try(:id)
  end

  def signed_in?
    current_user.present? and session[:user_id].present?
  end

  def login_required
    unless signed_in?
      flash[:notice] = "Please log in to continue"
      redirect_to root_path
    end
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
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


end

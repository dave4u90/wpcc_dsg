class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  @literals = Literal.all

  #define primary_languages - if the user has not defined any languages for the product. default
  #to english and french
  @primary_languages = Language.first

  before_filter :set_locale


  begin
    # do something dodgy
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "The resource is unavailable"
  rescue ActiveRecord::ActiveRecordError
    flash[:notice] = "Active Record Error occured. Please contact administrator."
  rescue # StandardError
    flash[:notice] = "Active Record Error occured. Please contact administrator."
  rescue Exception
    flash[:notice] = "Sorry an error occured. Please contact administrator."
  ensure
    redirect_to root_path and return
  end


  def set_locale
    if signed_in?
      if session[:locale].present?

      else
        session[:locale] = current_user.locale
      end
    end

    session[:locale] = "en" unless session[:locale].present?
    I18n.locale = session[:locale]

  end

  def change_locale(l)
    session[:locale] = l
    set_locale
  end

  def default_url_options(options = {})
    {:locale => I18n.locale}
  end


  def is_number?(object)
    true if Float(object) rescue false
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  @literals = Literal.all

  #define primary_languages - if the user has not defined any languages for the product. default
  #to english and french
  @primary_languages = Language.first

  before_filter :set_locale
  before_filter :set_time_zone

  #rescue_from Exception do |e|
  #logger.info "#{e.message}"
  #flash[:notice] = "Sorry an error occured. Please contact administrator."
  #if request.xhr?
  #render :js => "window.location.replace('#{root_url}')"
  #else
  #redirect_to "/" and return
  #end
  #end


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

  def set_time_zone
    min = request.cookies["time_zone"].to_i
    Time.zone = ActiveSupport::TimeZone[-min.minutes]
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

class LanguagesController < ApplicationController
  before_filter :login_required, except: [:show]

  def show()
    #change the language and the locale, and then redirect to the previous page
    lang = Language.find(params[:id])


    if lang == nil
      lang = Language.first
    end

    I18n.locale = lang.locale
    session[:locale] = I18n.locale


    sender = params[:sender]
    if sender == nil
      sender = "/"
    end

    #now redirect to previous page
    redirect_to sender
  end
end

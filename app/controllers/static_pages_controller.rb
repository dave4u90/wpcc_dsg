class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end
  
  def update_language
    session[:locale] = params[:language]
  end
  
end

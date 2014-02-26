class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
    @enquiry = Enquiry.new(params[:enquiry])
    if request.post?
      if verify_recaptcha(:model => @enquiry, :message => "Please enter correct captcha values.") && @enquiry.save
        flash[:notice] = "Thanks for communicating with us. We will get back to you shortly."
        redirect_to "/contact"
      else
        render :contact
      end
    end
  end

  def update_language
    session[:locale] = params[:language]
  end

end

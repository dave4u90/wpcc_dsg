class NewsLettersController < ApplicationController
  before_filter :login_required

  def create
    @news_letter = NewsLetter.new(params[:news_letter])
    if @news_letter.save
      render :js => "$('#suc_msg').html('You have been successfully subscribed. ');$('.fancybox-overlay').delay(1000).hide(0);"
    else
      render :js => "$('#mc_mandatory').html('#{@news_letter.errors.full_messages.to_sentence }');$('.fancybox-overlay').show();"
    end
  end
end

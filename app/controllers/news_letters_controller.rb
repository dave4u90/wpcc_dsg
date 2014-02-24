class NewsLettersController < ApplicationController
  def create
    @news_letter = NewsLetter.new(params[:news_letter])
    if @news_letter.save
      render :js => "$('suc_msg').html('You have been successfully subscribed. ');$('.fancybox-overlay').delay(1000).hide(0);" and return
    else
      render :js => "$('#mc_mandatory').html('#{@news_letter.errors.full_messages.to_sentence }');$('.fancybox-overlay').show();" and return
    end
  end
end

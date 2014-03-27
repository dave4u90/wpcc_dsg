class UserMailer < ActionMailer::Base
  default from: 'admin@workplacecarecentre.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail :to => user.email, :subject => t(:password_recover)
  end
  
  def send_reg_email(user) 
   # em = "fahad@hakimwealth.com"
    @email = user.email
    @user = user
#    mail(:to => @email, :from => "Admin - WPCC", :subject => "Account created.")
     mail(:to => @email, :subject => t(:account_created))
  end
  
  def request_access(user, product_instance)
    @user = user
    @product_instance = product_instance
    
    admins = product_instance.get_administrators
    admins.each do |aa|
      @email = aa.email
      mail(:to => @email, :subject => t(:access_request))
    end
    
  end
  
  def signator_new_product_registration_email(product_instance)
    #send an email to signator telling him that a new board has been registered in his/her name
    @products = ProductInstance.find_by_signator_email_address(product_instance.signator_email_address) 
    
    mail :to => product_instance.signator_email_address, :subject => t(:product_registration)
    
  end
  
end

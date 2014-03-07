class EnquiryMailer < ActionMailer::Base
  default from: "dave4u90@gmail.com"

  def enquiry_email(enquiry)
    @enquiry = enquiry
    mail(:to => "admin@workplacecarecentre.com", :subject => "WPCC Enquiry Email")
  end
end

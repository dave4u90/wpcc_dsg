class Enquiry < ActiveRecord::Base
  attr_accessor :phone_country_code

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: {message: "can not be blank."}, format: {with: VALID_EMAIL}, uniqueness: {case_sensitive: false}
  validates :name, :telephone, :message, presence: {message: "can not be blank."}

  after_create :send_enquiry_email

  def send_enquiry_email
    EnquiryMailer.enquiry_email(self).deliver
  end

end

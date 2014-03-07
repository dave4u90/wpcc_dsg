class Enquiry < ActiveRecord::Base
  attr_accessor :phone_country_code

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/i

  validates :email, presence: { message: "can not be blank."}, format: { with: VALID_EMAIL }, uniqueness: { case_sensitive: false }
  validates :name, :telephone, :message, presence: {message: "can not be blank."}
  validates :telephone, format: {with: VALID_PHONE}

end

class Product < ActiveRecord::Base

  attr_accessor :number_of_products
  attr_accessible :number_of_products

  validates :product_type_id, :registration_key, :presence => true
  def assign_registration_key
    generate_product_registration_key(:registration_key)
  end

  private

  def generate_product_registration_key(column)
    self[column] = SecureRandom.urlsafe_base64
  end
end

class Message < ActiveRecord::Base
  belongs_to :product_instance
  belongs_to :user
end

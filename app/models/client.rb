# == Schema Information
#
# Table name: clients
#
#  id                  :integer          not null, primary key
#  client_name         :string(255)
#  sector_id           :integer
#  address_id          :integer
#  watermark_image_url :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'carrierwave/orm/activerecord'

class Client < ActiveRecord::Base
  attr_accessible :client_name, :address_attributes,  :sector_id, :attachments_attributes
  has_many :product_instances
  has_many :users
  belongs_to :address
  accepts_nested_attributes_for :address
  belongs_to :sector

  has_many :attachments, as: :attachment_identifier, dependent: :destroy
  accepts_nested_attributes_for :attachments
  
  attr_accessible :sector_id, :address_id, :watermark_image_url, :client_name
  
  validates :sector_id, :client_name, presence: true

  #mount_uploader :image, ImageUploader
  
end

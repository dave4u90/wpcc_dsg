# == Schema Information
#
# Table name: product_instances
#
#  id                        :integer          not null, primary key
#  board_key                 :string(255)
#  client_id                 :integer
#  product_title               :string(255)
#  board_location_address_id :integer
#  signator_first_name       :string(255)
#  signator_last_name        :string(255)
#  signator_email_address    :string(255)
#  signator_telephone_number :string(255)
#  product_type_id             :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

require 'spec_helper'

describe ProductInstance do
  pending "add some examples to (or delete) #{__FILE__}"
end

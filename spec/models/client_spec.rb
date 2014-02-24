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

require 'spec_helper'

describe Client do
  pending "add some examples to (or delete) #{__FILE__}"
end

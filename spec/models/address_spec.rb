# == Schema Information
#
# Table name: addresses
#
#  id                    :integer          not null, primary key
#  line1                 :string(255)
#  line2                 :string(255)
#  line3                 :string(255)
#  city                  :string(255)
#  state_province_county :string(255)
#  country               :integer
#  other_address_details :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'spec_helper'

describe Address do
  pending "add some examples to (or delete) #{__FILE__}"
end

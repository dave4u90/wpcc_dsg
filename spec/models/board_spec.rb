# == Schema Information
#
# Table name: boards
#
#  id               :integer          not null, primary key
#  product_type_id    :integer
#  registration_key :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Board do
  pending "add some examples to (or delete) #{__FILE__}"
end

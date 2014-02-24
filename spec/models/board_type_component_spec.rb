# == Schema Information
#
# Table name: product_type_components
#
#  id            :integer          not null, primary key
#  product_type_id :integer
#  component_id  :integer
#  sequence      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe BoardTypeComponent do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: product_types
#
#  id                     :integer          not null, primary key
#  product_type_name        :string(255)
#  product_type_description :string(255)
#  upc_code               :string(255)
#  wpcc                   :string(255)
#  release_id             :string(255)
#  num_formplates         :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe BoardType do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: element_values
#
#  id                :integer          not null, primary key
#  element_value     :string(255)
#  form_element_id   :integer
#  product_instance_id :integer
#  form_instance_id  :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe ElementValue do
  pending "add some examples to (or delete) #{__FILE__}"
end

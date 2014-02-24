# == Schema Information
#
# Table name: components
#
#  id                    :integer          not null, primary key
#  component_description :string(255)
#  component_code        :string(255)
#  component_type_id     :integer
#  upc_code              :string(255)
#  direct_sub_components :integer
#  num_formplates        :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  language_id           :integer
#  icon_url              :string(255)
#

require 'spec_helper'

describe Component do
  pending "add some examples to (or delete) #{__FILE__}"
end

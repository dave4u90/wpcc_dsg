# == Schema Information
#
# Table name: component_types
#
#  id                         :integer          not null, primary key
#  component_type_description :string(255)
#  sequence                   :integer
#  supports_sub_components    :boolean
#  is_conceptual              :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  is_customizable            :boolean
#

require 'spec_helper'

describe ComponentType do
  pending "add some examples to (or delete) #{__FILE__}"
end

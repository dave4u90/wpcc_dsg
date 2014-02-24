# == Schema Information
#
# Table name: component_hierarchies
#
#  id                  :integer          not null, primary key
#  parent_component_id :integer
#  component_id        :integer
#  sequence            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe ComponentHierarchy do
  pending "add some examples to (or delete) #{__FILE__}"
end

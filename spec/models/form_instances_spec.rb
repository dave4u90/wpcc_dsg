# == Schema Information
#
# Table name: form_instances
#
#  id                    :integer          not null, primary key
#  form_id               :integer
#  language_id           :integer
#  form_instance_type_id :integer
#  form_plate_id         :integer
#  product_instance_id     :integer
#  created               :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'spec_helper'

describe FormInstance do
  pending "add some examples to (or delete) #{__FILE__}"
end

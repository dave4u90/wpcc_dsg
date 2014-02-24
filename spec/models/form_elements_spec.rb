# == Schema Information
#
# Table name: form_elements
#
#  id              :integer          not null, primary key
#  form_plate_id   :integer
#  caption         :string(255)
#  default_value   :string(255)
#  element_type_id :integer
#  html_residue    :string(255)
#  style           :string(255)
#  sequence        :string(255)
#  csv_list        :string(255)
#  sql_list        :string(255)
#  max_length      :integer
#  is_printed      :boolean
#  is_mandatory    :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe FormElement do
  pending "add some examples to (or delete) #{__FILE__}"
end

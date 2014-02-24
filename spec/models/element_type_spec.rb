# == Schema Information
#
# Table name: element_types
#
#  id                   :integer          not null, primary key
#  element_name         :string(255)
#  htmltag              :string(255)
#  csvlist              :string(255)
#  sqllist              :string(255)
#  islist               :boolean
#  isglobal             :boolean
#  has_inner_value_type :boolean
#  html_close_tag       :string(255)
#  element_value_field  :string(255)
#  has_caption          :boolean
#  is_editable          :boolean
#  max_length           :integer
#  html_class           :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'spec_helper'

describe ElementType do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: forms
#
#  id                  :integer          not null, primary key
#  product_form_nickname :string(255)
#  status_id           :integer
#  status_date         :datetime
#  product_instance_id   :integer
#  is_applicable       :boolean
#  formplate_id        :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe Form do
  pending "add some examples to (or delete) #{__FILE__}"
end

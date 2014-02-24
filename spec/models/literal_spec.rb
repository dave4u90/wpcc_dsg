# == Schema Information
#
# Table name: literals
#
#  id                      :integer          not null, primary key
#  literal_identifier_id   :integer
#  literal_identifier_type :string(255)
#  language_id             :integer
#  literal                 :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'spec_helper'

describe Literal do
  pending "add some examples to (or delete) #{__FILE__}"
end

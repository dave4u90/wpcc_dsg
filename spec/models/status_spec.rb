# == Schema Information
#
# Table name: statuses
#
#  id                 :integer          not null, primary key
#  status_text        :string(255)
#  status_icon_url    :string(255)
#  status_description :string(255)
#  sequence           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Status do
  pending "add some examples to (or delete) #{__FILE__}"
end

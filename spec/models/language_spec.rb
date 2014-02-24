# == Schema Information
#
# Table name: languages
#
#  id                   :integer          not null, primary key
#  language_description :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  is_supported         :boolean          default(FALSE)
#  locale               :string(255)
#

require 'spec_helper'

describe Language do
  pending "add some examples to (or delete) #{__FILE__}"
end

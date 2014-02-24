# == Schema Information
#
# Table name: formplates
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  validity       :integer
#  page_layout_id :integer
#  form_code      :string(255)
#  language_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Formplate do
  pending "add some examples to (or delete) #{__FILE__}"
end

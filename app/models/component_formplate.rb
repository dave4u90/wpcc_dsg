# == Schema Information
#
# Table name: component_formplates
#
#  id           :integer          not null, primary key
#  component_id :integer
#  formplate_id :integer
#  sequence     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ComponentFormplate < ActiveRecord::Base
  belongs_to :component
  belongs_to :formplate
end

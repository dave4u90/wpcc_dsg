# == Schema Information
#
# Table name: component_types
#
#  id                         :integer          not null, primary key
#  component_type_description :string(255)
#  sequence                   :integer
#  supports_sub_components    :boolean
#  is_conceptual              :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  is_customizable            :boolean
#

class ComponentType < ActiveRecord::Base
  has_many :components
  has_many :meta_data 
  has_many :meta_field
  
  has_many :literals, :as => :literal_identifier

  def get_title(language_id)
    if self.literals.size >= 1 
      l = self.literals.first.get_literal(language_id)
      return l.literal
    else
      return component_type_description
    end   
  end
end

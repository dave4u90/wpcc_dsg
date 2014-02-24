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

class Formplate < ActiveRecord::Base

  #Relationship between formplates and components

  has_many :component_formplates
  has_many :components, :through => :component_formplates

  #=====
  
  has_many :literals, :as => :literal_identifier
  
  has_many :form_elements, :order => "sequence"
  
  def get_title(language_id)
    if self.literals.size >= 1 
      l = self.literals.first.get_literal(language_id)
      return l.literal
    else
      return title
    end    
  end

  
  
end

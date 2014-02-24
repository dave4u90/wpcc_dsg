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


class Literal < ActiveRecord::Base
  belongs_to :literal_identifier, :polymorphic => true
  belongs_to :language

  def get_literal (language_id)
    
    if language_id == nil
      language_id = Language.english.id
    end
    
    
    
    list = Literal.where :literal_identifier_type => self.literal_identifier_type, :literal_identifier_id => self.literal_identifier_id, :language_id => language_id      
        
    if list.nil?
      #A literal for this language does not exist. Find English Literal.
      eng = Literal.where :literal_identifier_type => self.literal_identifier_type, :literal_identifier_id => self.literal_identifier_id, :language_id => Language.english.id     
      return eng.first + "(" + Language.english.to_s + ")"
    
    elsif list.count == 1
      return list.first
    else
      s = ""
      list.each do |l|
        s += l.literal + " | "        
      end
      return s
    end
  end
  
  def to_s()
    if self.literal.empty? 
      return self.literal
    else
      return self.literal.html_safe
    end
  end
  
end

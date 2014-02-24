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

class Language < ActiveRecord::Base
  has_many :literals
  
  has_and_belongs_to_many :product_instances

  def self.supported_languages()
    my_lang = []
    Language.all.each do |lang|
      if lang.is_supported
        my_lang.push lang
      end
    end
    return my_lang
  end
  
  def to_s()
    return language_description.to_s
  end
  
  def self.first
    return Language.supported_languages.first
  end
  
  def self.english
    en = Language.where ("locale='en'")
    if en
      return en.first
    else
      return first
    end    
  end
  
  def self.french()
    fr = Language.where ("locale='fr'")
    if fr
      return fr.first
    else
      return first
    end   
  end

end

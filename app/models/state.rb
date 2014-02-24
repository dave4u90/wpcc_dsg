# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  abbrev     :string(255)
#  country_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class State < ActiveRecord::Base
  
  belongs_to :country
  
  def cities()
    my_cities = Cities.where ("state='" + self.name + "' AND country='" + self.country.name + "'")
    return my_cities
  end
  
  def self.to_a()
    my_a = []
    State.all.each do |s|
      my_a.push s.name.humanize
    end
    return my_a
  end
end

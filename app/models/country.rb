# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  abbrev     :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ActiveRecord::Base
  
  has_many :states
  
  def self.to_a()
    my_a = []
    Country.all.each do |c|
      k =  [c.name.humanize, c.name]
      my_a.push k
    end
    return my_a
  end
end

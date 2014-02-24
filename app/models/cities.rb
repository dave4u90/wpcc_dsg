# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  cityname   :string(255)
#  state      :string(255)
#  country    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cities < ActiveRecord::Base
  def self.to_a()
    my_a = []
    Cities.all.each do |c|
      my_a.push c.cityname
    end
    return my_a
  end
  
end

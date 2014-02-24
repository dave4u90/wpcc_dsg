class Sector < ActiveRecord::Base

  def self.to_a()
    my_a = []
    Sector.all.each do |c|
      k =  [c.sector, c.id.to_s]
      my_a.push k
    end
    return my_a
  end
  
  def to_s
    return self.sector.to_s
  end
end

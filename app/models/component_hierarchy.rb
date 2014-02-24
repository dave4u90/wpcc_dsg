# == Schema Information
#
# Table name: component_hierarchies
#
#  id                  :integer          not null, primary key
#  parent_component_id :integer
#  component_id        :integer
#  sequence            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#


class ComponentHierarchy < ActiveRecord::Base
    belongs_to :component
    
   
   def self.get_max_sequence(parent_component_id)
    
    if parent_component_id == nil
        return 0
    end 
       
    res = ComponentHierarchy.where ("parent_component_id=" + parent_component_id.to_s)
    if res.empty?
        return 0
    else
        my_max = 0
        res.each do |r|
            if r.sequence != nil
                if my_max < r.sequence            
                    my_max = r.sequence
                end
            end
        end
    end
    
    return my_max
   end
      
end

# == Schema Information
#
# Table name: statuses
#
#  id                 :integer          not null, primary key
#  status_text        :string(255)
#  status_icon_url    :string(255)
#  status_description :string(255)
#  sequence           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Status < ActiveRecord::Base
  def self.get_status(status)
        statuses = Hash.new
    
    ##extended_properties has contains field names as keys. the values of these keys are Hash describiting their property values
    ##if a field does not exist in the extended_properties has, then it means it has no extended propertie
    ##---hard code the extended properties here. this is business logic.
    statuses[:new] = 0
    statuses[:in_progress] = 1

    statuses[:need_review] = 2
    statuses[:ready_to_print] = 3
    statuses[:printed_and_published] = 4


        
    
    h = statuses
    return h[status]

  end
  def self.status_new()
    return self.get_status (:new)
  end
  def self.status_in_progress()
    return self.get_status (:in_progress)
  end
  def self.status_need_review()
    return self.get_status (:need_review)
  end
  def self.status_ready_to_print()
    return self.get_status (:ready_to_print)
  end
  def self.status_printed_and_published()
    return self.get_status (:printed_and_published)
  end
  
  def self.is_edit_able(status)
    #if the status is ready for print - this means it has been reviewed, and cant be edited.
    #they must save as a new version.
    if status < 3
      return true
    else
      return false
    end
    
  end
end

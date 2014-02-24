#-------------------March 17 - dont need this anymore.
#------decide if a form instance is custom or standard by having a is_standard boolean in form_instance model





# == Schema Information
#
# Table name: form_instance_types
#
#  id                 :integer          not null, primary key
#  form_instance_desc :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class FormInstanceType < ActiveRecord::Base

end

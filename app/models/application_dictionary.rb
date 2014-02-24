# == Schema Information
#
# Table name: application_dictionaries
#
#  id          :integer          not null, primary key
#  literal_key :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ApplicationDictionary < ActiveRecord::Base
end

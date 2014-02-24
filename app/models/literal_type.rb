# == Schema Information
#
# Table name: literal_types
#
#  id         :integer          not null, primary key
#  table_name :string(255)
#  class_name :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class LiteralType < ActiveRecord::Base
end

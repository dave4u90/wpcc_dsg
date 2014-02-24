# == Schema Information
#
# Table name: page_layouts
#
#  id                      :integer          not null, primary key
#  page_layout_description :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class PageLayout < ActiveRecord::Base
end

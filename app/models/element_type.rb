# == Schema Information
#
# Table name: element_types
#
#  id                   :integer          not null, primary key
#  element_name         :string(255)
#  htmltag              :string(255)
#  csvlist              :string(255)
#  sqllist              :string(255)
#  islist               :boolean
#  isglobal             :boolean
#  has_inner_value_type :boolean
#  html_close_tag       :string(255)
#  element_value_field  :string(255)
#  has_caption          :boolean
#  is_editable          :boolean
#  max_length           :integer
#  html_class           :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ElementType < ActiveRecord::Base
  belongs_to :validation
  
  
  #this method will use regular expression validation to validate value specified in 'vv' against
  #--validation that is associated to this element_type. This is the default validation for an element
  #---whose validation is not defined.
  def default_validate_value(vv)
    if self.validation == nil
      return true
    else
      if self.validation.empty?
        return true
      else
        #validate. regular expression is stored in self..validation.expr
        return value.to_s.match(self.validation.expr) != nil
      end
    end
  end
end

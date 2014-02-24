class ElementTypePdf < Prawn::Document

def initialize(elementtype, view)
	a = []
    super()
    @elementtype = elementtype
    @view = view
    text "This is a print of the element"

    text "This is the next line"
    for attribute in @elementtype.attributes.keys
    	 text "['#{attribute.humanize}','#{@elementtype.attributes[attribute].to_s}']"
    	# text "#{@elementtype.attributes[attribute].to_s}"
    #a.push("['#{attribute.humanize}','#{@elementtype.attributes[attribute].to_s}']")
    #a.push("'#{@elementtype.attributes[attribute].to_s}'']")
 	end

 	#table([a], :width => 700 )

 	

  end


end






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

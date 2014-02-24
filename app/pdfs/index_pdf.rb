#!/bin/env ruby
# encoding: utf-8

class IndexPdf < Prawn::Document

def initialize(elementvalues, view)
	
    super()
    @elementvalues = elementvalues
    @view = view
     text "WPCC™ 1                  INDEX               Commitment  -  Engagement", :align => :center

move_down 10
text "Prior to addressing the tabs within this binder, please review the information on the reverse side of this index."

move_down 20
            @elementvalues.each do |element|
                text " #{element.element_value} " 
                move_down 15
            end


end
end
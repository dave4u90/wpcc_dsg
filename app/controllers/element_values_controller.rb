class ElementValuesController < ApplicationController

	def index
		@elementvalues = ElementValue.all 
		respond_to do |format|
				format.html
				format.pdf do
					pdf = IndexPdf.new(@elementvalues, view_context)
					send_data pdf.render, filename:
					"elementvalues.pdf",
					type: "application/pdf", disposition: "inline"
				end
			end
	end



end

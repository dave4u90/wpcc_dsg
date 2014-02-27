class ElementTypesController < ApplicationController
  before_filter :login_required
  before_filter :only_talott_allowed, only: [:edit]

  def new
  end

  def index
    @elementtypes = ElementType.paginate(page: params[:page])
  end

  def show
    @elementtype = ElementType.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ElementTypePdf.new(@elementtype, view_context)
        send_data pdf.render, filename:
            "elementtype.pdf",
                  type: "application/pdf", disposition: "inline"
      end
    end

  end

end

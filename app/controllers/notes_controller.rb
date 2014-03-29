class NotesController < ApplicationController
  before_filter :login_required

  def index()
  @product_instances = []
    user_id = params[:user_id]
    if user_id != nil
      @user = User.find(user_id)
      #get client for this user
      #get product_instances for this client
      #get notes for all product_instances
      if @user != nil
        @user.user_accesses.each do |ua|
          @product_instances.push ua.product_instance
        end
      end
    end


    product_instance_id = params[:product_instance_id]
    if product_instance_id != nil
      pi = ProductInstance.find(product_instance_id)
      if pi != nil?
        @product_instances.push pi
      end
    end


    @notes_container = @product_instances.compact
    @current_language_id = ApplicationHelper.current_language_id
  end

  def create()
    if params[:note][:id].present?
      @note = Note.find(params[:note][:id])
      @note.update_attributes(params[:note])
    else
      @note = Note.new(params[:note])
      @note.save
    end
    session[:current_draft] = @note.try(:id)
    if request.xhr?
      if @note.note_object_type == "ProductInstance"
        render js: "console.log('product instance note drafted');"
      else
        render js: "window.location.reload();console.log('component note drafted');"
      end
    else
      @note.update_attribute(:is_draft, false)
      session[:current_draft] = nil
      if @note.note_object_type == ProductInstance.class.to_s
        redirect_to notes_path(:product_instance_id => @note.product_instance_id.to_s)
      else
        redirect_to :back
      end
    end
  end
end

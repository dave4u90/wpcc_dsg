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
    @note = Note.new (params[:note])
    @note.save

    if @note.note_object_type == ProductInstance.class.to_s
      redirect_to notes_path(:product_instance_id => @note.product_instance_id.to_s)
    else
      redirect_to :back
    end

  end
end

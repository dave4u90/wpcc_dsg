class FormsController < ApplicationController
  before_filter :login_required
  helper :all

  def show

    load_variables

    #the edit mode variable will tell the show_html.erb wether or not to show fields as readonly. false means readonly, and true means not readonly
    @edit_mode = false

  end

  def update


    ###validation logic assumption
    #--each element will be independently evaluated to ensure its value is valid.
    #--if the value for the element is valid, then it will be saved. Even if other values for other elements might not
    #---be valid. A new revision version be created with the valid values that are saved. 

    #internal flag to decide if we want to save or not.
    do_save = false

    #set the response message with successful at the begining
    @msg = t(:changes_saved_successfully)

    #initialize invalid_elements
    @invalid_elements = Hash.new

    #initialize successfully_updated
    @successfully_updated = Hash.new

    #interal boolean variable to indicate success/failure. for message purposes
    b_success = true

    #invalid field and their old values.
    @invalid_values = Hash.new

    #internal boolean variable to indicate whether any element was actually modified
    b_changes_made = false

    #find relevant forminstance and product_instance
    #    @form_instance = FormInstance.find(params[:form_instance_id])
    #    @product_instance = ProductInstance.find(params[:product_instance_id])

    #    @form = @form_instance.form

    load_variables


    ##if save action "newversion" is then current version should be a new version.

    if params.include?("commit")
      @current_version = @form_instance.get_current_version(@user.id)
      @current_version.status_id = Status.status_in_progress
      do_save = true
    end
    if params.include?("newversion")
      @current_version = @form_instance.create_new_version(@user.id)
      @current_version.status_id = Status.status_new
      do_save = true
    end
    if params.include?("history")
      redirect_to @form_instance #versions - which will show the history of this form-instance
      return
    end
    if params.include?("print_draft")
      redirect_to @current_version
      return
    end
    if params.include?("flag_for_review")
      redirect_to @current_version
      return
    end


    #check to see if commit button for saving formplate was pressed.
    if do_save


      #loop through the params to find the posted values from the form
      params.each do |pp|

        #form elements are rendered as "e[elementID]", so it will be matched using regex. The numeric element id will be
        #wrapped in the index-1 position of MatchData array (element_match)
        element_match = pp[0].to_s.match(/^e([\d]+)$/)

        #if it doesnt match, then match data will be nil - so ignore these values
        if element_match != nil

          #index-1 instance of the regex MatchData is the digits contained. Index-0 contains the whole text matched
          element_id = element_match[1]


          #load up the element
          @element = FormElement.find(element_id)

          # the new value is stored in pp[1].
          #---------------

          #validate the new value pp[1] - if validates then save.
          if @element.is_valid (pp[1])

            #save the value
            @element.save_value(@form_instance, @product_instance, pp[1], @current_version)

            #element was updated successfully, so update that in here
            @successfully_updated[pp[0]] = pp[1]


            #changes were made
            b_changes_made = true

          else

            #store invalid elements in the hash, and the invalid elements values here.
            @invalid_elements[pp[0]] = pp[1]

            @msg = t(:not_all_changes_saved)

            b_success = false
            b_changes_made = true

          end


          ###testing invalid elements
          #store invalid elements in the hash, and the invalid elements values here.
          #@invalid_elements [pp[0]] = pp[1]

        end

      end #end param.each loop
    end #end if commit

    #now update the header fields - if the save header action is executed      
    if params["save_header"] != ""
      #update form header fields
      update_form_headers(@form, params)

      @form.save
    end

    #if there werent any changes made, show approrpirate message
    if b_changes_made != true
      @msg = t(:no_changes_made)
      b_success = true
    else
      #update the amended field with current date/time
      @form.update_attribute "amended", Time.zone.now

      if @invalid_elements.empty?
        @msg = :change_saved_successfully
      end

    end


    @edit_mode = true

    render 'show'
  end

  def edit
    @form = Form.find(params[:id])

    #the edit mode variable will tell the show_html.erb wether or not to show fields as readonly. false means readonly, and true means not readonly
    @edit_mode = true

    params = request.parameters

    render 'show'
  end


  #f is the form object, and p is the params hash
  def update_form_headers(f, p)
    #first update form_title
    update_form_name(f, p)

    #now loop through the params to find the matching header fields.
    p.each do |pp|
      #form's header fields are using format (f[formid]_[form field name]). so it will be matched using regex. The formid will be wrapped
      #in the index-1 position of the matched data array, and the fieldname will be matched index-2
      form_field_match = pp[0].to_s.match(/^f([\d]+)_(.+)$/)

      if form_field_match != nil
        #so the param at current loop index is a valid field name. Now check to see if this param is in th attributes list.
        if f.attributes.include?(form_field_match[1])
          #so the parsed value is a valid attribute. Now lets do some validations:
          #1. check to see if this is a readonly field.
          if f.is_read_only (form_field_match[1])
            invalid_element_ids.push pp[0]
          else
            if f.is_valid(form_field_match[1])
              #so its not ready only and its valid
              f.update_attribute(form_field_match[1], pp[1])

              successfully_updated[pp[0]] = pp[1]
            else
              invalid_elements[pp[0]] = pp[1]
            end #if is-valud
          end
        end
      end
    end

  end

  def update_form_name(f, p)
    #since custom_name for the form is a different case (because of languages) - save it, if its available
    if p[f.get_html_form_field("product_form_nickname")] != ""
      if f.is_valid("product_form_nickname", p[f.get_html_form_field("product_form_nickname")])
        #so if the form is valid then save the changes
        f.change_form_custom_name @form_instance.language_id, p[@form.get_html_form_field("product_form_nickname")]
        @successfully_updated[f.get_html_form_field("product_form_nickname")] = p[f.get_html_form_field("product_form_nickname")]

      else
        #the valud is not valid, so flag this field and puts its value in a hash for
        @invalid_elements[f.get_html_form_field("product_form_nickname")] = p[f.get_html_form_field("product_form_nickname")]
      end
    end

  end

  def load_variables()
    @user = current_user
    @form = Form.find(params[:id])
    @language = Language.find (current_language_id)
    @product_instance = @form.product_instance
    @component_id = params[:component_id]

    if @component_id
      @component = Component.find(@component_id)
    end


  end

  def current_language_id()
    return 1
  end
end

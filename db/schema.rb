# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 201401200234026) do

  create_table "access_role", :force => true do |t|
    t.string   "role_description"
    t.string   "key"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "addresses", :force => true do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "line3"
    t.string   "city"
    t.string   "state_province_county"
    t.string   "country"
    t.string   "other_address_details"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "post_zip_code"
  end

  create_table "application_dictionaries", :force => true do |t|
    t.string   "literal_key"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "attachments", :force => true do |t|
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.integer  "attachment_identifier_id"
    t.string   "attachment_identifier_type"
    t.integer  "language_id"
    t.string   "search_tags"
  end

  create_table "audit_trails", :force => true do |t|
    t.integer  "audit_trail_message_id"
    t.integer  "user_id"
    t.string   "ip_address"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "cityname"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "client_name"
    t.integer  "sector_id"
    t.integer  "address_id"
    t.string   "watermark_image_url"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "component_formplates", :force => true do |t|
    t.integer  "component_id"
    t.integer  "formplate_id"
    t.integer  "sequence"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "component_hierarchies", :force => true do |t|
    t.integer  "parent_component_id"
    t.integer  "component_id"
    t.integer  "sequence"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "component_types", :force => true do |t|
    t.string   "component_type_description"
    t.integer  "sequence"
    t.boolean  "supports_sub_components"
    t.boolean  "is_conceptual"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "is_customizable"
    t.text     "view_handler",               :default => "box"
  end

  create_table "components", :force => true do |t|
    t.string   "component_description"
    t.string   "component_code"
    t.integer  "component_type_id"
    t.string   "upc_code"
    t.integer  "direct_sub_components"
    t.integer  "num_formplates"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "language_id"
    t.string   "icon_url"
    t.text     "image_url",             :default => "0"
    t.integer  "image_id"
    t.integer  "parent_component_id"
    t.string   "photo"
  end

  create_table "countries", :force => true do |t|
    t.string   "abbrev"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "custom_components", :force => true do |t|
    t.integer "component_id"
    t.integer "product_instance_id"
    t.integer "sequence"
    t.string  "custom_component_title"
  end

  create_table "d_loggers", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "element_types", :force => true do |t|
    t.string   "element_name"
    t.string   "htmltag"
    t.string   "csvlist"
    t.string   "sqllist"
    t.boolean  "islist"
    t.boolean  "isglobal"
    t.boolean  "has_inner_value_type"
    t.string   "html_close_tag"
    t.string   "element_value_field"
    t.boolean  "has_caption"
    t.boolean  "is_editable"
    t.integer  "max_length"
    t.string   "html_class"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "validation_id"
  end

  create_table "element_values", :force => true do |t|
    t.string   "element_value"
    t.integer  "form_element_id"
    t.integer  "product_instance_id"
    t.integer  "form_instance_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "form_instance_version_id"
  end

  create_table "field_maps", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "form_elements", :force => true do |t|
    t.integer  "formplate_id"
    t.string   "caption"
    t.string   "default_value"
    t.integer  "element_type_id"
    t.string   "html_residue"
    t.string   "style"
    t.integer  "sequence"
    t.string   "csv_list"
    t.string   "sql_list"
    t.integer  "max_length"
    t.boolean  "is_printed"
    t.boolean  "is_mandatory"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "validation_id"
  end

  create_table "form_instance_types", :force => true do |t|
    t.string   "form_instance_desc"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "form_instance_versions", :force => true do |t|
    t.integer  "form_instance_id"
    t.integer  "user_id"
    t.integer  "version"
    t.integer  "revision"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "status_id",        :default => 0
  end

  create_table "form_instances", :force => true do |t|
    t.integer  "form_id"
    t.integer  "language_id"
    t.integer  "form_instance_type_id"
    t.integer  "formplate_id"
    t.integer  "product_instance_id"
    t.string   "created"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.boolean  "is_custom"
  end

  create_table "formplates", :force => true do |t|
    t.string   "title"
    t.integer  "validity"
    t.integer  "page_layout_id"
    t.string   "form_code"
    t.integer  "language_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "forms", :force => true do |t|
    t.string   "product_form_nickname"
    t.integer  "status_id",             :default => 1
    t.datetime "status_date"
    t.integer  "product_instance_id"
    t.boolean  "is_applicable"
    t.integer  "formplate_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "prepared_by_user_id"
    t.date     "review"
    t.date     "amended"
    t.text     "location"
    t.text     "documents"
    t.text     "document_number"
    t.text     "legislations"
  end

  create_table "images", :force => true do |t|
    t.string   "image_url"
    t.decimal  "height_width_ratio"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "language_description"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.boolean  "is_supported",         :default => false
    t.string   "locale"
  end

  create_table "literal_types", :force => true do |t|
    t.string   "table_name"
    t.string   "class_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "literals", :force => true do |t|
    t.integer  "literal_identifier_id"
    t.string   "literal_identifier_type"
    t.integer  "language_id"
    t.text     "literal"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "language_id"
    t.text     "message"
    t.text     "subject"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "metadata", :force => true do |t|
    t.integer  "metadata_identifier_id"
    t.string   "metadata_identifier_type"
    t.string   "key"
    t.integer  "metafield_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "language_id",              :default => 1
  end

  create_table "metafield", :force => true do |t|
    t.integer  "metafield_identifier_id"
    t.string   "metafield_identifier_type"
    t.string   "key"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "news_letters", :force => true do |t|
    t.string   "full_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notes", :force => true do |t|
    t.text     "note"
    t.integer  "user_id"
    t.integer  "product_instance_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "subject"
    t.integer  "component_id"
    t.string   "note_object_type"
  end

  create_table "page_layouts", :force => true do |t|
    t.string   "page_layout_description"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "postal_codes", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "country"
    t.integer  "country_id"
    t.integer  "state_province_county_id"
    t.string   "postal_code"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "province"
  end

  create_table "product_instances", :force => true do |t|
    t.string   "product_key"
    t.integer  "client_id"
    t.string   "product_title"
    t.integer  "product_location_address_id"
    t.string   "signator_first_name"
    t.string   "signator_last_name"
    t.string   "signator_email_address"
    t.string   "signator_telephone_number"
    t.integer  "product_type_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "product_instances_languages", :force => true do |t|
    t.integer  "language_id"
    t.integer  "product_instance_id"
    t.integer  "sequence"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "product_keys", :force => true do |t|
    t.integer  "product_type_id"
    t.string   "product_key"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "product_type_components", :force => true do |t|
    t.integer  "product_type_id"
    t.integer  "component_id"
    t.integer  "sequence"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "product_types", :force => true do |t|
    t.string   "product_type_name"
    t.string   "product_type_description"
    t.string   "upc_code"
    t.string   "wpcc"
    t.string   "release_id"
    t.integer  "num_formplates"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "icon_url"
  end

  create_table "products", :force => true do |t|
    t.integer  "product_type_id"
    t.string   "registration_key"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "descriptor"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sectors", :force => true do |t|
    t.string   "sector"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "status_text"
    t.string   "status_icon_url"
    t.string   "status_description"
    t.integer  "sequence"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "user_access", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_instance_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "access_role_id",      :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                :default => false
    t.integer  "address_id"
    t.integer  "client_id"
    t.string   "password_reset_token"
    t.datetime "password_sent_at"
    t.string   "locale"
    t.boolean  "is_active",            :default => false
    t.boolean  "email_confirmed",      :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "validations", :force => true do |t|
    t.string   "title"
    t.string   "expr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

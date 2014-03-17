class ProductInstance < ActiveRecord::Base

  has_many :meta_datas
  has_many :meta_fields, :as => :metafield_identifier

  has_many :literals, :as => :literal_identifier

  has_many :notes


  has_many :user_accesses

  belongs_to :client
  belongs_to :product_type

  has_many :forms
  has_many :product_instance_languages
  belongs_to :address, :foreign_key => "product_location_address_id", :class_name => "Address"

  accepts_nested_attributes_for :client, :address, :user_accesses
  attr_accessor :phone_country_code


  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_TELEPHONE = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/

  validates :product_title, presence: true, length: {minimum: 10}
  validates :product_key, presence: true
  validates :product_type_id, presence: true
  validates :signator_first_name, :signator_last_name, presence: true, length: {maximum: 50}
  validates :signator_email_address, presence: true, format: {with: VALID_EMAIL}
  validates :signator_telephone_number, presence: true, format: {with: VALID_TELEPHONE}


  #define fieldmap for extended properties  
  def get_extended_property(field_name, property_key)

    h = get_extended_properties
    return FieldMap.get_property(h, field_name, property_key)

  end


  def self.find_by_signator_email_address(email_addr)
    res = ProductInstance.where ("signator_email_address LIKE '" + email_addr + "'")
    return res
  end

  def get_pending_user_approvals()
    pending_users = []
    self.user_accesses.each do |ua|
      if ua.user
        if ua.user.is_active
        else
          pending_users.push ua.user
        end
      end
    end
    return pending_users
  end

  def self.object_title_array(arr, lang_id)
    new_arr = []
    arr.each do |a|
      k = []
      k[0] = ActionView::Base.full_sanitizer.sanitize(a.get_title(lang_id))
      k[1] = a.id
      new_arr.push k
    end
    return new_arr
  end

  def is_language_installed(language)
    if self.product_instance_languages.empty?
      return false
    end

    self.product_instance_languages.each do |l|
      if l.language_id == language.id
        return true
      end
    end
    return false
  end

  def install_language(lang)
    if is_language_installed(lang)
      return lang
    else
      l = self.product_instance_languages.new
      l.language_id = lang.id
      l.save
      return l

      return nil
    end
  end

  def get_extended_properties()
    ###define extended properties here
    extended_properties = Hash.new

    ##extended_properties has contains field names as keys. the values of these keys are Hash describiting their property values
    ##if a field does not exist in the extended_properties has, then it means it has no extended propertie
    ##---hard code the extended properties here. this is business logic.
    extended_properties["product_key"] = Hash["tab_order" => 1, "validation_regex" => "", "is_read_only" => true, "is_required" => true, "is_rendered" => true]
    extended_properties["signator_first_name"] = Hash["tab_order" => 2, "validation_regex" => "", "is_read_only" => false, "is_required" => true, "is_rendered" => true]
    extended_properties["signator_last_name"] = Hash["tab_order" => 3, "validation_regex" => "", "is_read_only" => false, "is_required" => true, "is_rendered" => true]
    extended_properties["signator_email_address"] = Hash["tab_order" => 4, "validation_regex" => "", "is_read_only" => false, "is_required" => true, "is_rendered" => true]
    extended_properties["signator_telephone"] = Hash["tab_order" => 5, "validation_regex" => "", "is_read_only" => false, "is_required" => true, "is_rendered" => true]

    h = extended_properties
    return h
  end


  def get_title(language_id)
    if self.literals.size >= 1
      l = self.literals.first.get_literal(language_id)
      return l.literal
    else
      return product_title
    end
  end

  def get_languages()
    languages = []
    if self.product_instance_languages.count == 0
      languages.push Language.first
    else
      self.product_instance_languages.each do |pil|
        languages.push pil.language
      end
    end
    return languages
  end

  def formatted_product_key()
    return ProductKey.formatted_product_key(self.product_key)
  end

  def self.get_new_key(product_type)
    return ProductKey.get_unused_key(product_type)
  end

  def self.product_instance_by_key(key)
    res = ProductInstance.where ("product_key='" + key.to_s + "'")
    if res.empty?
      return nil
    else
      return res.first
    end
  end

  def self.is_valid_key(key_string)
    return ProductKey.valid_key (key_string)
  end

  def self.key_in_use(key_string)
    res = ProductInstance.where ("product_key='" + key_string.to_s + "'")
    if res.empty?
      return false
    else
      return true
    end

  end


  def create_user_access(user)
    ua = UserAccess.new
    ua.product_instance_id = self.id
    ua.user_id = user.id
    ua.access_role_id = AccessRole.get_admin_id # admin
    ua.save
  end


  def get_administrators()
    my_administrator = []
    self.user_accesses.each do |ua|
      if ua
        if ua.is_administrator
          my_administrator.push ua.user
        end
      end
    end
    return my_administrator
  end

  def has_administrators()
    if self.get_administrators.size == 0
      return false
    else
      return true
    end
  end

  def get_users()
    my_users = []
    prev_u = nil
    self.user_accesses.each do |ua|
      if ua.user == prev_u
      else
        prev_u = ua.user
        my_users.push (ua.user)
      end
    end
    return my_users
  end

  def add_administrator_role(my_user)


    #validation to make sure we have a valid user
    if my_user.nil?
      return
    else
      if my_user.id.nil?
        return
      end
    end


    if self.id.nil?
    else
      uas = UserAccess.where ("user_id=" + my_user.id.to_s + " AND product_instance_id=" + self.id.to_s + " AND access_role_id=" + AccessRole.get_administrator_id.to_s)
    end


    if uas.empty?
      ua = self.user_accesses.new
      ua.user_id = my_user.id
      ua.product_instance_id = self.id=
          ua.access_role_id = AccessRole.get_administrator_id
      ua.save
      return ua
    else
      return uas.first
    end

  end

  def add_crud_role(my_user)

    uas = UserAccess.where ("user_id=" + my_user.id.to_s + " AND product_instance_id=" + self.id.to_s + " AND access_role_id=" + AccessRole.get_crud_id.to_s)

    if uas.empty?
      ua = UserAccess.new
      ua.user_id = my_user.id
      ua.product_instance_id = self.id
      ua.access_role_id = AccessRole.get_crud_id
      ua.save
      return ua
    else
      return uas.first
    end

  end

  def remove_administrator_role(my_user)
    uas = UserAccess.where ("product_instance_id=" + self.id.to_s)
    if uas.empty?
      return
    else
      #now add regular user access
      self.add_crud_role my_user

      #remove user_access
      uas.each do |ua|
        if ua.user_id = my_user.id
          if ua.is_administrator
            return ua.remove_access
          end
        end
      end
    end

  end

  def get_meta_fields(language_id)
    my_meta = []
    self.product_type.meta_fields.each do |m|
#      if m.language_id = language_id
      my_meta.push (m)
#      end

    end

    return my_meta
  end

  def get_form(fp)
    if fp == nil
      return nil
    else

      #if we dont have a form for the product_instance, then create an empty form
      f = (Form.where :formplate_id => fp.id).first
      if f == nil
        f = Form.new
        f.formplate_id = fp.id
        f.product_instance_id = self.id
        f.product_form_nickname = fp.title

        #enter default title for the form (this would be the formplate_title)
        fp.literals.each do |fp_l|
          f_l = f.custom_title.new()
          f_l.language_id = fp_l.language_id
          f_l.literal = fp_l.literal
          f_l.save()
        end
        f.save()
      end
      return f
    end
  end
end

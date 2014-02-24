# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  email                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  password_digest      :string(255)
#  remember_token       :string(255)
#  admin                :boolean          default(FALSE)
#  address_id           :integer
#  client_id            :integer
#  password_reset_token :string(255)
#  password_sent_at     :datetime
#  locale               :string(255)
#

class User < ActiveRecord::Base
	attr_accessor :product_instance_id
	attr_accessible :name, :address, :email, :password, :password_confirmation, :locale, :product_instance_id, :is_admin, :client_id, :email_confirmation, :address_attributes, :client_attributes
	
	has_secure_password
	
	belongs_to :language
	belongs_to :client
	
	belongs_to :address
	has_many :user_accesses
		
	accepts_nested_attributes_for :address, :client


	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

#	after_create :add_admin


	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :email, presence: true, format: { with: VALID_EMAIL }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 7 }
	validates :password_confirmation, presence: true
	validates_confirmation_of :email
	
	def get_accesses(product_instance_id)
		my_accesses = []
		self.user_accesses.each do |ua|
			if ua.product_instance_id == product_instance_id
				my_accesses.push ua	
			end			
		end
		return my_accesses
	end
	
	def mail_to_s()
		return User.mail_to_s self.name, '', self.email
	end
	def product_instances()
		product_instances = []
		self.user_accesses.each do |ua|
			if ua.product_instance != nil
				product_instances.push ua.product_instance
			end
		end
		return product_instances
	end
	def is_talott()
		self.user_accesses.each do |ua|
			if ua.access_role.is_talott
				return true
			end			
		end
		return false
	end
	
	def suspend_user(product_instance)
		u = self
		if u == nil
		  return false
		else
		  #check to see if this is the last standing admin for the product_instance
		  admin_check = false
		  if (u.is_administrator product_instance)
		    admins = (UserAccess.find_administrators_by_product_instance product_instance.id)
		    admin_check = admins.size <= 1
		  end
		  
		  if admin_check
		    return false
		  else
		    u.update_attribute "is_active", false
		    u.save
		  end      
		end
	end
	
	
	def is_administrator(product_instance)
		if product_instance == nil
			return false
		end
		
		#get admins for the product-instance and check to see if this user is in the list
		admins = product_instance.get_administrators
		admins.each do |a|
			if a
				if a.id == self.id
					return true
				end
			end
		end
		return false
	end
	
	def has_crud_access(product_instance)
		if product_instance.id == nil
			return false
		end
		
		uas = self.user_accesses.where ("product_instance_id=" + product_instance.id.to_s)
		if uas.empty?
			return false
		else
			if uas.first.is_crud || uas.first.is_administrator
				return true
			end			
		end
		
	end
	
	def get_address_html()
		if self.address
			return self.address.to_html_s
		end		
	end
	
	def self.mail_to_s(first, last, email)
		return "<a href='mailto:" + email + "'>" + first + ' ' + last + "</a>"
	end
	
	def add_product_instance_access(product_key)
		if product_key.nil?
			return
		else
			prod = ProductInstance.product_instance_by_key(product_key)
			if prod.nil?
				return
			end			
		end
		
		
	
		#if prod has no administrator, then create an admin, otherwise, create crud
		if prod.has_administrators
			prod.add_crud_role self
		else
			prod.add_administrator_role self
		end
		
	end
		
	
	
	def create_default_user_access(product_instance)
		ua = self.user_accesses.new
		ua.product_instance_id = product_instance.id
		ua.access_role_id = AccessRole.get_crud_id
		ua.save
		return ua
	end
	
	def send_password_reset
			generate_token(:password_reset_token)
			self.password_sent_at = Time.zone.now
			self.save
#			save!(:validate => false)
			UserMailer.password_reset(self).deliver
	end

	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end


#		def generate_token(column)
#    		begin
#      			self[column] = SecureRandom.urlsafe_base64
#    		end while User.exists?(column => self[column])
#  		end

		def generate_token(a)
			t = SecureRandom.urlsafe_base64
			self.update_attribute :password_reset_token, t
			self.save
			return t
		end

			
end






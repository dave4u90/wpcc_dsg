# == Schema Information
#
# Table name: addresses
#
#  id                    :integer          not null, primary key
#  line1                 :string(255)
#  line2                 :string(255)
#  line3                 :string(255)
#  city                  :string(255)
#  state_province_county :string(255)
#  country               :integer
#  other_address_details :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Address < ActiveRecord::Base
	attr_accessible :line1, :line2, :line3, :city, :state_province_county, :country, :other_address_details, :post_zip_code

	has_one :client
  has_one :product_instance
	
	
	def my_updatable_attributes
		to_remove = []
		#to_return = []
		to_return = self.attributes.clone
		self.attributes.each do |a|
			if Address.accessible_attributes.include?(a[0])
			else
				to_remove.push a
				to_return.delete a[0]
			end			
		end
		return to_return
	end
	def fill(arr)
		
		if arr.class == self.class
			my_obj = arr.my_updatable_attributes
		else
			my_obj = arr
		end
		
		
		my_obj.each do |a|
			self.update_attribute a[0], a[1]
		end
		self.update_attribute "id", ""
#		self.save
	end
	def fill_from_address(addr)
		self.fill(addr.my_updatable_attributes)
	end
	
	def to_html_s
		s = self.line1 + "<br />"
		s += self.line2 + "<br />"
		if self.line3
			s += self.line3 + "<br />"
		end
		s += self.city	 + ", " + self.state_province_county + "<br/>"
		s += self.country + " " + self.post_zip_code
		
		return s
	
	end
end


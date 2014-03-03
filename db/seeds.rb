puts "Seeding data"



require 'csv'
require 'benchmark'
require 'carrierwave/orm/activerecord'


DEFAULT_IMAGES_FOLDER_FOR_TEST = "c:/ruby193/wpcc_hegel/app/assets/images"


#<!-- ADDING ROLES -->

 
puts "/n/nAdding roles"
AccessRole.delete_all
CSV.foreach("#{Rails.root}/lib/assets/AccessRoles.csv", {encoding: "ISO-8859-1", :headers => :first_row}) do |row|
   ar = AccessRole.new
   ar.key = row[2]
   ar.role_description = row[1]
   ar.save
   
   puts "--" + ar.role_description
      
   arl = ar.literals.new
   arl.language_id=1 #english
   arl.literal = ar.role_description
   arl.save
   
   
   puts "----" + arl.literal

   arl = ar.literals.new
   arl.language_id=2 #french
   arl.literal = ar.role_description + "-FR"
   arl.save

   puts "----" + arl.literal

end
#<!--------------------- -->





#<!-- ADDING Languages -->
#--5. Load Languages 
#------These are the languages that the system loads by default

# Table name: languages
#
#  id                   :integer          not null, primary key
#  language_description :string(255)
puts "Adding Languages"

Language.delete_all
CSV.foreach("#{Rails.root}/lib/assets/Languages.csv", {encoding: "ISO-8859-1", :headers => :first_row}) do |row|
      l =   Language.new(:language_description => row[1],
                          :locale => row[2])
          
      puts "--" + l.language_description
      
      l.is_supported = row[3]

      #l.id = row[0]

      l.save()

end

#<!--------------------- -->





#<!-- ADDING USERS -->
puts "Adding users"
User.delete_all
CSV.foreach("#{Rails.root}/lib/assets/Users.csv", {encoding: "ISO-8859-1"}) do |row|
   u = User.new
   u.name  = row[1]
   u.email = row[2]
   u.password = row[3]
   u.password_confirmation = row[3]
   u.client_id = row[4]
   u.is_active = true
   u.save
   
   puts "--" + u.id.to_s + ")" + u.name
end
#<!--------------------- -->


#
#
#
#
#
#
#
#
#
#
#<!-- ADDING USERACCESS -->

puts "Adding user access"
UserAccess.delete_all
CSV.foreach("#{Rails.root}/lib/assets/UserAccess.csv", {encoding: "ISO-8859-1", :headers => :first_row}) do |row|
   ua = UserAccess.new
#   UserAccess.create! (
   ua.user_id = row[1]
   ua.product_instance_id = row[2]
   ua.access_role_id = row[3]
   ua.save
   
   puts "--" + ua.user.name.to_s + " <-> " + ua.access_role.role_description
   
end

#<!--------------------- -->
#
#
#
#
#
#
#
#
#
#
#
#<!-- ADDING ElementTypes -->

puts "Adding Element Types"
ElementType.delete_all
CSV.foreach("#{Rails.root}/lib/assets/ElementTypes.csv", {encoding: "utf-8", :headers => :first_row }) do |row|
   et = ElementType.new
   et.element_name = row[1]
   et.htmltag = row[2]
   et.csvlist = row[3]
   et.sqllist = row[4]
   et.islist = row[5]
   et.isglobal = row[6]
   et.has_inner_value_type =  row[7]
   et.html_close_tag = row[8]
   et.element_value_field = row[9]
   et.has_caption = row[10]
   et.is_editable = row[11]
   et.max_length = row[12]
   et.html_class = row[13]
   et.save
   
   puts "--" + et.element_name
end

#<!--------------------- -->
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#<!-- ADDING Countries -->

puts "Adding Countries"
Country.delete_all
CSV.foreach("#{Rails.root}/lib/assets/countries.csv", {:col_sep => ";", encoding: "utf-8", :headers => :first_row}) do |row|
   c = Country.new
   if row[1] != nil
      c.name = row[1]
      if row[2] != nil
         c.abbrev = row[2]
      end
      c.save      
   end
   
   
   puts "--" + c.name

   
end

#<!--------------------- -->

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#<!-- ADDING Cities -->

puts "Adding Cities"
Cities.delete_all
CSV.foreach("#{Rails.root}/lib/assets/cities.csv", {encoding: "utf-8", :headers => :first_row}) do |row|
   cty = Cities.new
   cty.cityname = row[0]
   cty.state = row[1] 
   cty.country = row[2]
   cty.save
   
   puts "--" + cty.cityname
end

#<!--------------------- -->
#
#
#
#

#<!-- ADDING Postal Codes -->

puts "Adding Postal Codes"
PostalCode.delete_all
CSV.foreach("#{Rails.root}/lib/assets/postal_codes.csv", {encoding: "utf-8", :headers => :first_row}) do |row|
   post_code = PostalCode.new
   post_code.postal_code = row[0]
   post_code.street = row[1]
   post_code.city = row[2]
   post_code.province = row[3] 
   post_code.country = row[4]
   post_code.country_id = row[5]
   post_code.state_province_county_id = row[6]
   post_code.save
   
   puts "--" + post_code.postal_code + " city=" + post_code.city
end

#<!--------------------- -->
#
#
#
#


puts "Adding States and Provinces"
State.delete_all
CSV.foreach("#{Rails.root}/lib/assets/state.csv") do |row|
   st = State.new
   st.abbrev = row[1] 
   st.name = row[0]
   st.country_id = "2"
   st.save
   
   puts "--" + st.name
end
CSV.foreach("#{Rails.root}/lib/assets/provinces.csv") do |row|
   st = State.new
   st.abbrev = row[1] 
   st.name = row[0]
   st.country_id = "1"
   st.save
   
   puts "--" + st.name
end

#<!--------------------- -->
#
#
#
#
#
#
#
#
#<!-- ADDING Literals -->
skip_items = ["Component", "ComponentType", "ProductType"]
puts "Adding Literals"
#--0. Load Literals
#------These the descriptive names for various object_types (ex: Component, Product_Type etc...)
#------Literals have to be loaded first from the CSV, because the seed will add additional literals for ProductType etc.. and primary
#---------key here is more important for assosiations
# Table name: literals
#
#  id                          :integer          not null, primary key
#  literal                     :text
#  literal_identifier_id       :integer
#  literal_identifier_type     :integer
#  language_id                 :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
Literal.delete_all
CSV.foreach("#{Rails.root}/lib/assets/Literals.csv", {encoding: "ISO-8859-1", :headers => :first_row}) do |row|
       
      
      l =   Literal.new(:literal_identifier_id => row[1],
               :literal_identifier_type => row[2],
               :language_id => row[3],
               :literal => row[4]
               )
      #l.id = row[0]
      
      puts "--" + l.literal
      
      #ignore items that are included in the skipitems list.
      if !skip_items.include?(l.literal_identifier_type)
         l.save()
      end
            
end
#<!--------------------- -->
#
#
#
#
#
#
#
#
#
##<!-- ADDING ELEMENT_VALUES -->
#time = Benchmark.realtime {
#puts "Adding element values"
##Model for element values
##  element_value     :string(255)
##  form_element_id   :integer
##  product_instance_id :integer
##  form_instance_id  :integer
##  created_at        :datetime         not null
##  updated_at        :datetime         not null
#
#ElementValue.delete_all
#
###insert code here to load preset values - in prod - this should probably be empty.
#
#}
#puts "Elapsed time: #{time}"
##<!--------------------- -->
#
#
#
#
#
#
#
#
#
#
#
#<!-- ADDING Product Instances -->
#in prod: these will be the instances that we test with.
puts "Adding product instances"
ProductInstance.delete_all


CSV.foreach("#{Rails.root}/lib/assets/ProductInstances.csv", {:col_sep => ",", :headers => :first_row, encoding: "utf-8"}) do |row|
   p = ProductInstance.create!(
        :product_key => row[1],  
        :client_id => row[2], 
        :product_title => row[3],
        :product_location_address_id => row[4],
        :signator_first_name => row[5],
        :signator_last_name => row[6],
        :signator_email_address => row[7],
        :signator_telephone_number => row[8],
        :product_type_id => row[9]       
        )
   
   p.install_language(Language.first)
      
   puts "--" + p.product_key
    
   n = p.notes.new
   n.subject = "Test Subject"
   n.note = "Hi this is my test note"
   n.user_id = 1
   n.product_instance_id = p.id
   n.note_object_type = 'ProductInstance'
   n.save
   
   puts "----" + n.subject
   
end

#puts "Elapsed time: #{time}"
##<!--------------------- -->
#
#
#
#
#
#
#
#
#
#
#
#<!-- ADDING Product Types -->
puts "Adding product types"
ProductType.delete_all
CSV.foreach("#{Rails.root}/lib/assets/ProductType.csv", {encoding:'iso-8859-1:utf-8', :headers => :first_row}) do |row|
   
      bt = ProductType.new(product_type_name: row[1], product_type_description: row[2],
            upc_code: row[3],
         wpcc: row[4],
         release_id: row[5],
         num_formplates: row[6],
         icon_url: row[7]
         )
      #bt.id = row[0]
      bt.save()
      
      puts "--" + bt.product_type_name
      
      
      if bt.product_type_name != nil
         k = bt.literals.new(:literal => bt.product_type_name, :language_id => 1)
         k.save()    
      end
      
      puts "----" + k.literal
      
      
      #French Literal
      k = bt.literals.new
      k.language_id = 2 #French
      k.literal = row[8]
      k.save
      
      
      puts "----" + k.literal
      
      #Spanish Literal
      k = bt.literals.new
      k.language_id = 3 #Spanish
      k.literal = row[9]
      k.save
      
      
      puts "----" + k.literal
      
      
      
      #generate some new keys for each product type
      5.times do |loopcount|
         uselessvariable = ProductKey.new_key (bt)      
      end
      
      
end
#}
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
##<!-- ADDING ProductTypeComponents -->
##Note: Matching Id's is VERY important there. 

puts "Adding product type components"
##--2. Load ProductTypeComponents
##------These are associations that identify which component belongs to which Product
#
## Model for product_type_components
##
##  id            :integer          not null, primary key
##  product_type_id :integer
##  component_id  :integer
##  sequence      :integer
##  created_at    :datetime         not null
##  updated_at    :datetime         not null
##
ProductTypeComponent.delete_all
CSV.foreach("#{Rails.root}/lib/assets/ProductTypeComponents.csv", {encoding:'iso-8859-1:utf-8', :headers => :first_row}) do |row|
   if row[0] != "ProductTypeComponentID"
      btc = ProductTypeComponent.new(
         :product_type_id => row[1],
         :component_id => row[2],
         :sequence => row[3])

      #btc.id = row[0]
      btc.save()
      
      puts "--" + btc.id.to_s
      
   end
end

##<!--------------------- -->
#
#
#
#
#
#
#
#
#
#
#
#
#
##<!-- ADDING Components -->
#time = Benchmark.realtime {
##--3. Load Components
##------These all the components that go on the product. This include sub-components as well
#
#
## Model for components
##  component_description :string(255)
##  component_code        :string(255)
##  component_type_id     :integer
##  upc_code              :string(255)
##  direct_sub_components :integer
##  num_formplates       :integer
##  created_at            :datetime         not null
##  updated_at            :datetime         not null
puts "Adding components"
Component.delete_all
CSV.foreach("#{Rails.root}/lib/assets/Components.csv", {encoding:'iso-8859-1:utf-8', :headers => :first_row}) do |row|

  if row[1] != nil
      #code
     
      c = Component.new
      c.component_description = row[1]
      c.component_type_id = row[3]
      c.upc_code = row[4]
      c.direct_sub_components = row[5]
      c.num_formplates = row[6]
      c.icon_url = row[7]
      c.image_url = row[8]
      c.image_id = row[9]
      
      #c.id = row[0]
      c.save()
      
      puts "--" + c.component_description
      
      l = c.literals.new
      l.language_id = 1 #english
      l.literal = row[2] #component description in english
      l.save
      
      puts "----" + l.literal
      
      l = c.literals.new
      l.language_id = 2 #french #TOCHANGE: this should be the row of french values
 
      l.literal = row[2]
      
      if l.literal != nil
           l.literal = l.literal + " -FR"
      end
            
      l.save
      
      puts "----" + l.literal     
  end
    
end
#

##<!--------------------- -->
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#<!-- ADDING Images -->
puts "Adding Images"
Image.delete_all
CSV.foreach("#{Rails.root}/lib/assets/Images.csv", {encoding:'iso-8859-1:utf-8', :headers => :first_row}) do |row|
   if row[0] != "ComponentID" 
     c = Image.new
     
     puts "--test: " + row[1]

     my_file = File.open "#{Rails.root}/app/assets/images/" + row[1]
     
     c.image_url.store! my_file
     #c.id = row[0]
     c.save()
     
     
     puts "--" + c.image_url.class.to_s
   end
end


#<!--------------------- -->
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
##<!-- ADDING ComponentHierarchies -->
##--3. Load ComponentsHierarchies 
##------These the associations that specify which component belongs under which component
#
#
## Model for component_hierarchies
##
##  id                   :integer          not null, primary key
##  parent_component_id  :integer
##  component_id         :integer
##  sequence             :integer
##  created_at           :datetime         not null
##  updated_at           :datetime         not null
##
puts "Adding component hierarchy"
ComponentHierarchy.delete_all
CSV.foreach("#{Rails.root}/lib/assets/ComponentHierarchies.csv", {encoding: "ISO-8859-1", :headers => :first_row}) do |row|
   if row[0] != "ComponentHierarchyID" 
      ch =   ComponentHierarchy.new(:parent_component_id => row[1],
       :component_id => row[2],
       :sequence => row[3])
      
      #ch.id = row[0]
      ch.save()
      
      puts "--" + ch.parent_component_id.to_s + "<->" + ch.component_id.to_s
   end
end 


##<!--------------------- -->
#
#
#
#
#
#
#
#
#
#
#
#
#
#
##<!-- ADDING ComponentTypes -->
#time = Benchmark.realtime {
##--4. Load ComponentTypes 
##------These the associations what type of component we are dealing with (Tab, binder etc...)
#
## Table name: component_types
##
##  id                         :integer          not null, primary key
##  component_type_description :string(255)
##  sequence                   :integer
##  supports_sub_components    :boolean
##  is_conceptual              :boolean
##  created_at                 :datetime         not null
##  updated_at                 :datetime         not null
##
puts "Adding component types"
ComponentType.delete_all
CSV.foreach("#{Rails.root}/lib/assets/ComponentTypes.csv", {encoding: "ISO-8859-1",  :headers => :first_row}) do |row|
  
      ct =   ComponentType.new(:component_type_description => row[1], :sequence => row[2], :supports_sub_components => row[3], :is_conceptual => row[4])
      #working on this one!!!
      #ct.id = row[0]
      ct.view_handler = row[5]
      ct.save()
      
      puts "--" + ct.component_type_description
      
      #english literal
      k = ct.literals.new
      k.literal = ct.component_type_description
      k.language_id = 1 #english
      k.save() 
      
      puts "----" + k.literal
      
      #french literal
      k = ct.literals.new
      k.literal = row[6] #French Value
      k.language_id = 2 #FRENCH
      k.save()

      puts "----" + k.literal

      #spanish literal
      k = ct.literals.new
      k.literal = row[7] #Spanish Value
      k.language_id = 3 #Spanish
      k.save()

      puts "----" + k.literal

end 


##<!--------------------- -->
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
##--6. Load Formplates
##------These are the formplates
#
## Table name: formplates
##
##  id              :integer          not null, primary key
##  category_id     :integer
##  title :string(255)
##  validity_period :integer
##  page_layout_id  :integer
##  form_code       :string(255)
##  language_id     :integer
##  created_at      :datetime         not null
##  updated_at      :datetime         not null
#
#
puts "Adding Default Formplates"
Formplate.delete_all
CSV.foreach("#{Rails.root}/lib/assets/Formplates.csv", {:headers => :first_row}) do |row|
   if row[0] != "FormplateID" && row[0] != "" ##ignore header
      f=Formplate.new()
      f.title = row[1]
      f.validity = row[2]
      f.page_layout_id = row[3]
      f.form_code  = row[4]
      f.language_id = row[5]
      f.save()
      
      puts "--" + f.title
      
      #english
      fl = f.literals.new
      fl.language_id = 1 #english
      fl.literal = f.title
      fl.save
      
      puts "----" + fl.literal
      
      #french
      fl = f.literals.new
      fl.language_id = 2 #french
      fl.literal = row[6]
      fl.save

      puts "----" + fl.literal
      
   end
end
##<!--------------------- -->
#
#
#
#
#
#
#
#
#
#












#
#
#
##--7. Load ComponentFormplates
##------These are the associations of formplates belonging to components
#
puts "Adding Component Formplates"
ComponentFormplate.delete_all
CSV.foreach("#{Rails.root}/lib/assets/ComponentFormPlates.csv", {:headers => :first_row}) do |row|
      cf= ComponentFormplate.new()
      cf.component_id = row[1]
      cf.formplate_id = row[2]
      cf.sequence = row[3]
      cf.save()
      
      puts "--" + cf.formplate_id.to_s 
end
#


















#
##--8. Load FormElements
##------These are the associations of elements that comprise the formplate
puts "Adding FormElements"
FormElement.delete_all
CSV.foreach("#{Rails.root}/lib/assets/FormElements.csv") do |row|
   if row[0] != "FormElementID" && row[0] != "" ##ignore header
      fe=FormElement.new()
      fe.id = row[0]
      fe.formplate_id = row[1]
      fe.caption = row[2]
      fe.default_value = row[3]
      fe.element_type_id = row[4]
      fe.html_residue = row[5]
      fe.style = row[6]
      fe.sequence = row[7]
      fe.csv_list = row[8]
      fe.sql_list = row[9]
      fe.max_length = row[10]
      fe.is_printed = row[11]
      fe.is_mandatory = row[12]      
      fe.save()
      
      puts "--" + fe.caption
   end
end





#--------------->
























#
##--Load Clients
##------These are the associations of elements that comprise the formplate
puts "Adding Clients"
Client.delete_all
CSV.foreach("#{Rails.root}/lib/assets/client.csv", {:headers => :first_row}) do |row|
   if row[0] != "client_id" && row[0] != "" ##ignore header
      c = Client.new
      c.client_name = row[1]
      c.sector_id = row[2]
      c.address_id = row[3]
      c.watermark_image_url = row[4]
      
      c.save
      
      puts "--" + c.client_name
   end
end
#------------------------>






























#
##--Load Addresses
##------These are the associations of elements that comprise the formplate
puts "Adding Addresses"
Address.delete_all
CSV.foreach("#{Rails.root}/lib/assets/Address.csv", {:headers => :first_row}) do |row|
   if row[0] != "address_id" && row[0] != "" ##ignore header
      a = Address.new
      a.line1 = row[1]
      a.line2 = row[2]
      a.line3 = row[3]
      a.city = row[4]
      a.state_province_county = row[5]
      a.country = row[6].humanize  
      a.post_zip_code = row[7]
      a.save
      
      puts "--" + a.line1
   end
end
#------------------------>


































#
##--Load Sector
##------These are the associations of elements that comprise the formplate
puts "Adding Sectors"
Sector.delete_all
CSV.foreach("#{Rails.root}/lib/assets/sectors.csv", {:headers => :first_row}) do |row|
   if row[0] != "sector_id" && row[0] != "" ##ignore header
      s = Sector.new
      s.sector = row[1]
     
      s.save
      
      puts "--" + s.sector
   end
end
#------------------------>
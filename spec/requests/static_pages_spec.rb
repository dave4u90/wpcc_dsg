require 'spec_helper'

describe "StaticPages" do

	subject { page }
 
 describe "Home page" do
 	before {visit root_path}

 	it { should have_selector('title', text: full_title('')) }
 	it { should_not have_selector 'title', text: '| Home' }
 end
 


 describe "About page" do
 	before {visit about_path}

 	it { should have_selector('title', text: full_title('About Us')) }
 

 end

 describe "Contact page" do
 	before {visit contact_path}

 	it { should have_selector('title', text: full_title('Contact Us')) }
end

end

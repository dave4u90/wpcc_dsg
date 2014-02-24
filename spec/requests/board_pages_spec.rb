require 'spec_helper'

describe "Board pages" do

  subject {page}

  describe "register page" do
  	before {visit register_path}

  	it {should have_selector('h1', text: 'Register')}
  	it {should have_selector('title', text: full_title('Register'))}
  end
  
end

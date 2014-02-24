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

require 'spec_helper'

describe User do
	before do
   		@user = User.new(name: "Example User", email: "user@example.com",
   			password: "password", password_confirmation: "password")
	end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }  

  it {should be_valid}
  it {should_not be_admin}

  describe "when name is not entered" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "when email is not entered" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "when email is invalid" do
    it "should be invalid" do
      addresses = %w[user@domain,com user_at_domain.org example.user@domain.
                     user@dom_ain.com user@dom+ain.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email is valid" do
    it "should be valid" do
      addresses = %w[user@domain.COM A_US-ER@a.b.org frst.lst@domain.jp a+b@domain.ca]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "when email address is a duplicate" do
  	before do
  		user_with_duplicate_email = @user.dup
  		user_with_duplicate_email.email = @user.email.upcase
  		user_with_duplicate_email.save
  	end

  	it { should_not be_valid}

  end

  describe "when password is ommitted" do
  	before { @user.password = @user.password_confirmation = " " }
  	it {should_not be_valid}
  end

  describe "when password and confirmation do not match" do
  	before { @user.password_confirmation = "mismatch" }
  	it {should_not be_valid}
  end

  describe "when password confirmation is not entered" do
  	before { @user.password_confirmation = nil }
  	it {should_not be_valid }
end

describe "return value of authenticate method" do
  before { @user.save }
  let(:found_user) { User.find_by_email(@user.email) }

  describe "with valid password" do
    it { should == found_user.authenticate(@user.password) }
  end

  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not == user_for_invalid_password }
    specify { user_for_invalid_password.should be_false }
  end
end

describe "with a password that is too short" do
  before { @user.password = @user.password_confirmation = "a" * 5 }
  it { should be_invalid }
end

describe "remember token" do
  before { @user.save }
  its(:remember_token) {should_not be_blank}
end

describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end



end

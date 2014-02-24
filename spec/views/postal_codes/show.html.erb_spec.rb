require 'spec_helper'

describe "postal_codes/show" do
  before(:each) do
    @postal_code = assign(:postal_code, stub_model(PostalCode,
      :street => "Street",
      :city => "City",
      :id => "",
      :country => "Country",
      :country_id => 1,
      :state_province_county_id => 2,
      :postal_code => "Postal Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Street/)
    rendered.should match(/City/)
    rendered.should match(//)
    rendered.should match(/Country/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Postal Code/)
  end
end

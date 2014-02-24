require 'spec_helper'

describe "postal_codes/index" do
  before(:each) do
    assign(:postal_codes, [
      stub_model(PostalCode,
        :street => "Street",
        :city => "City",
        :id => "",
        :country => "Country",
        :country_id => 1,
        :state_province_county_id => 2,
        :postal_code => "Postal Code"
      ),
      stub_model(PostalCode,
        :street => "Street",
        :city => "City",
        :id => "",
        :country => "Country",
        :country_id => 1,
        :state_province_county_id => 2,
        :postal_code => "Postal Code"
      )
    ])
  end

  it "renders a list of postal_codes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Postal Code".to_s, :count => 2
  end
end

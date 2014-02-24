require 'spec_helper'

describe "postal_codes/new" do
  before(:each) do
    assign(:postal_code, stub_model(PostalCode,
      :street => "MyString",
      :city => "MyString",
      :id => "",
      :country => "MyString",
      :country_id => 1,
      :state_province_county_id => 1,
      :postal_code => "MyString"
    ).as_new_record)
  end

  it "renders new postal_code form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => postal_codes_path, :method => "post" do
      assert_select "input#postal_code_street", :name => "postal_code[street]"
      assert_select "input#postal_code_city", :name => "postal_code[city]"
      assert_select "input#postal_code_id", :name => "postal_code[id]"
      assert_select "input#postal_code_country", :name => "postal_code[country]"
      assert_select "input#postal_code_country_id", :name => "postal_code[country_id]"
      assert_select "input#postal_code_state_province_county_id", :name => "postal_code[state_province_county_id]"
      assert_select "input#postal_code_postal_code", :name => "postal_code[postal_code]"
    end
  end
end

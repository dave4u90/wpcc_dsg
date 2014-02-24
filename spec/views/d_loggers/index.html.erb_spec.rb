require 'spec_helper'

describe "d_loggers/index" do
  before(:each) do
    assign(:d_loggers, [
      stub_model(DLogger,
        :name => "Name",
        :description => "Description",
        :id => ""
      ),
      stub_model(DLogger,
        :name => "Name",
        :description => "Description",
        :id => ""
      )
    ])
  end

  it "renders a list of d_loggers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end

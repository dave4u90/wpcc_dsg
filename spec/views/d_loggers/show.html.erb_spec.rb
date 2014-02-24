require 'spec_helper'

describe "d_loggers/show" do
  before(:each) do
    @d_logger = assign(:d_logger, stub_model(DLogger,
      :name => "Name",
      :description => "Description",
      :id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(//)
  end
end

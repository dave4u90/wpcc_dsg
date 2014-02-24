require 'spec_helper'

describe "d_loggers/edit" do
  before(:each) do
    @d_logger = assign(:d_logger, stub_model(DLogger,
      :name => "MyString",
      :description => "MyString",
      :id => ""
    ))
  end

  it "renders the edit d_logger form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => d_loggers_path(@d_logger), :method => "post" do
      assert_select "input#d_logger_name", :name => "d_logger[name]"
      assert_select "input#d_logger_description", :name => "d_logger[description]"
      assert_select "input#d_logger_id", :name => "d_logger[id]"
    end
  end
end

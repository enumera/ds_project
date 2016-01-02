require 'spec_helper'

describe "saltydog_groups/show" do
  before(:each) do
    @saltydog_group = assign(:saltydog_group, stub_model(SaltydogGroup,
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end

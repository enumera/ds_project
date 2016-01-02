require 'spec_helper'

describe "saltydog_groups/edit" do
  before(:each) do
    @saltydog_group = assign(:saltydog_group, stub_model(SaltydogGroup,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit saltydog_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => saltydog_groups_path(@saltydog_group), :method => "post" do
      assert_select "input#saltydog_group_name", :name => "saltydog_group[name]"
      assert_select "input#saltydog_group_description", :name => "saltydog_group[description]"
    end
  end
end

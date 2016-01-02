require 'spec_helper'

describe "saltydog_groups/new" do
  before(:each) do
    assign(:saltydog_group, stub_model(SaltydogGroup,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new saltydog_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => saltydog_groups_path, :method => "post" do
      assert_select "input#saltydog_group_name", :name => "saltydog_group[name]"
      assert_select "input#saltydog_group_description", :name => "saltydog_group[description]"
    end
  end
end

require 'spec_helper'

describe "items/new" do
  before(:each) do
    assign(:item, stub_model(Item,
      :name => "MyString",
      :category => "MyString",
      :price => 1.5,
      :condition => "MyString",
      :location => "MyString",
      :description => "MyText",
      :seller_id => 1
    ).as_new_record)
  end

  it "renders new item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_name", :name => "item[name]"
      assert_select "input#item_category", :name => "item[category]"
      assert_select "input#item_price", :name => "item[price]"
      assert_select "input#item_condition", :name => "item[condition]"
      assert_select "input#item_location", :name => "item[location]"
      assert_select "textarea#item_description", :name => "item[description]"
      # this will be generated, not provided by user
      #assert_select "input#item_seller_id", :name => "item[seller_id]"
    end
  end
end

require 'spec_helper'

describe "items/edit" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :name => "MyString",
      :category => "MyString",
      :price => 1.5,
      :condition => "MyString",
      :location => "MyString",
      :description => "MyText",
      :seller_id => 1
    ))
  end

  it "renders the edit item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path(@item), :method => "post" do
      assert_select "input#item_name", :name => "item[name]"
      assert_select "input#item_category", :name => "item[category]"
      assert_select "input#item_price", :name => "item[price]"
      assert_select "input#item_condition", :name => "item[condition]"
      assert_select "input#item_location", :name => "item[location]"
      assert_select "textarea#item_description", :name => "item[description]"
      assert_select "input#item_seller_id", :name => "item[seller_id]"
    end
  end
end

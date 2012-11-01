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

end

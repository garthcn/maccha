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

end

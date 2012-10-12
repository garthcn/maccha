require 'spec_helper'

describe "items/show" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :name => "Name",
      :category => "Category",
      :price => 1.5,
      :condition => "Condition",
      :location => "Location",
      :description => "MyText",
      :seller_id => 1
    ))
  end

  it "renders attributes in <p>" do

  end
end

require 'spec_helper'

describe "items/index" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :name => "Name",
        :category => "Category",
        :price => 1.5,
        :condition => "Condition",
        :location => "Location",
        :description => "MyText",
        :seller_id => 1
      ),
      stub_model(Item,
        :name => "Name",
        :category => "Category",
        :price => 1.5,
        :condition => "Condition",
        :location => "Location",
        :description => "MyText",
        :seller_id => 1
      )
    ])
  end

  it "renders a list of items" do

  end
end

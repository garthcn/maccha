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
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Category/)
    rendered.should match(/1.5/)
    rendered.should match(/Condition/)
    rendered.should match(/Location/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end

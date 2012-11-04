require 'spec_helper'

describe "items/show.html.erb" do
  before(:each) do
		@item = FactoryGirl.create(:item)
		get :show, :id => @item.id
  end

	context "for guests" do
		it "should show current price" do
			response.should have_tag("p.curr", "Current Price:")
		end

		it "should not render bidding button" do

		end
	end

	context "for logged in users" do
		it "should render bidding button" do
			render "/users/sign_up"
			fill_in "Email",                 :with => "alindeman@example.com"
			fill_in "Password",              :with => "ilovegrapes"
			fill_in "Password confirmation", :with => "ilovegrapes"
			page.should have_content "Place Bid"
		end
	end
end

require 'spec_helper'

describe "Items" do
  describe "GET /items" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get items_path
      response.status.should be(200)
    end
	end

	describe "show page" do
		before(:each) do
			@item = FactoryGirl.create(:item)
			visit "/items/#{@item.id}"
		end

		context "for guests" do
			it "should show current price" do
				page.should have_content "Current Price:"
			end

			it "should not render bidding button" do
				page.should_not have_content "Place Bid"
			end
		end

		context "for logged in users" do
			it "should render bidding button" do
				pending
				login_user
				visit "/items/#{@item.id}"
				page.save_page
				page.should have_content "Place Bid"
			end
		end
	end
end

class NotifyMailer < ActionMailer::Base
  default from: "macchacmu@gmail.com"

	def buyer_win_auction(item,buyer)
		@item = item
		@buyer = buyer
		@url = item_url(@item)
		mail(:to => buyer.email, :subject => "You won #{@item.name}!")
	end

	def buyer_lost_auction(item,buyer)
		@item = item
		@buyer = buyer
		@url = item_url(@item)
		mail(:to => buyer.email, :subject => "You lost in the auction for #{@item.name}")
	end

	def seller_auction_result(seller,bid)
		@seller = seller
		@bid = bid
		@item = @bid.item
		@buyer = @bid.user
		@url = item_url(@item)
		mail(:to => seller.email, :subject => "Your #{@item.name} has been sold!")
	end
end

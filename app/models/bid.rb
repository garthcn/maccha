class Bid < ActiveRecord::Base
  attr_accessible :amount, :bid_time, :buyer_id, :item_id, :seller_id
end

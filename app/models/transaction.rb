class Transaction < ActiveRecord::Base
  attr_accessible :buyer_id, :is_shipped, :item_id, :price, :seller_id
end

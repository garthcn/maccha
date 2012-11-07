# == Schema Information
#
# Table name: bids
#
#  id         :integer          not null, primary key
#  seller_id  :integer
#  buyer_id   :integer
#  item_id    :integer
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  expired_at :datetime
#  status     :integer
#

class Bid < ActiveRecord::Base
  attr_accessible :price, :buyer_id, :item_id, :seller_id, :created_at, :updated_at
  validates :price,
            :presence => true,
            :numericality => { :greater_than =>0, :less_than => 99999999 }

	def larger?(new_price)
	  new_price > self.price
	end
end

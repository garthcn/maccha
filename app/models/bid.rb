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
  attr_accessible :price, :buyer_id, :item_id, :seller_id, :created_at,
    :updated_at, :cancel_request, :cancel_reason,  :expired_at, :status

  belongs_to :user, :foreign_key => 'buyer_id'
  belongs_to :item

  validates :price,
            :presence => true,
            :numericality => { :greater_than =>0, :less_than => 99999999 }

	def larger?(new_price)
	  new_price > self.price
	end

	def self.user_highest_bid(item_id, user_id)
		self.order("price DESC").find_all_by_item_id_and_buyer_id(item_id,user_id).first
	end

	def apply_to_cancel_account
    @bid = Bid.find(params[:bid_id])
    @item = @bid.item
    reason = params[:cancel_reason] || ''
    respond_to do |format|
      if @bid.update_attributes(cancel_request: true, cancel_reason: reason)
        format.html { redirect_to @item, notice: 'Application submitted. Please wait for confirmation.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @item, notice: 'There was something wrong. Application was not submitted.'  }
        format.json { head :no_content }
      end
    end
  end
end

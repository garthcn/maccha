# == Schema Information
#
# Table name: transactions
#
#  id         :integer          not null, primary key
#  seller_id  :integer
#  buyer_id   :integer
#  item_id    :integer
#  price      :integer
#  is_shipped :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Transaction < ActiveRecord::Base
  attr_accessible :buyer_id, :is_shipped, :item_id, :price, :seller_id
  
  belongs_to :user, :foreign_key => 'buyer_id'
  belongs_to :item
  
end

class UserType < ActiveRecord::Base
  attr_accessible :buyer_type, :seller_type, :user_id
  # belongs_to :user
end

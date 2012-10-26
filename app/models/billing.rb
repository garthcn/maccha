class Billing < ActiveRecord::Base
  attr_accessible :billing_addr, :cc, :paypal, :shipping_addr, :user_id
  belongs_to :user
end

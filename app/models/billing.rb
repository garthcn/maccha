# == Schema Information
#
# Table name: billings
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  credit_card   :string(255)
#  paypal        :string(255)
#  billing_addr  :text
#  shipping_addr :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Billing < ActiveRecord::Base
  attr_accessible :billing_addr, :credit_card, :paypal, :shipping_addr, :user_id
  belongs_to :user
end

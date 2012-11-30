# == Schema Information
#
# Table name: bids
#
#  id             :integer          not null, primary key
#  seller_id      :integer
#  buyer_id       :integer
#  item_id        :integer
#  price          :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  expired_at     :datetime
#  status         :integer
#  cancel_request :boolean
#  cancel_reason  :text
#

require 'spec_helper'

describe Bid do
  #pending "add some examples to (or delete) #{__FILE__}"
end

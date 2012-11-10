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

require 'spec_helper'

describe Transaction do
  pending "add some examples to (or delete) #{__FILE__}"
end

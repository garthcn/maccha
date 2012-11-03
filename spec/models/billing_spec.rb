# == Schema Information
#
# Table name: billings
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  cc            :string(255)
#  paypal        :string(255)
#  billing_addr  :text
#  shipping_addr :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Billing do
  #pending "add some examples to (or delete) #{__FILE__}"
end

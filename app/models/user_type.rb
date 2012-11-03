# == Schema Information
#
# Table name: user_types
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  buyer_type  :integer
#  seller_type :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserType < ActiveRecord::Base
  attr_accessible :buyer_type, :seller_type, :user_id
  # belongs_to :user
end

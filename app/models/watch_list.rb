# == Schema Information
#
# Table name: watch_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WatchList < ActiveRecord::Base
  attr_accessible :item_id, :user_id
  belongs_to :user
end

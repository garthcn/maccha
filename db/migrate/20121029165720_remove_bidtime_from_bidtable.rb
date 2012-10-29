class RemoveBidtimeFromBidtable < ActiveRecord::Migration
  def up
    remove_column :bids, :bid_time
  end

  def down
    add_column :bids, :bid_time, :datetime
  end
end

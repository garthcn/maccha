class ChangebidColumnname < ActiveRecord::Migration
  def up
    rename_column(:bids, :amount, :price)
  end

  def down
    rename_column(:bids, :price, :amount)
  end
end

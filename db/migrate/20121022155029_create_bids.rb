class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :item_id
      t.float :amount
      t.datetime :bid_time

      t.timestamps
    end
  end
end

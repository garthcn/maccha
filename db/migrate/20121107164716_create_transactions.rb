class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :item_id
      t.integer :price
      t.boolean :is_shipped

      t.timestamps
    end
  end
end

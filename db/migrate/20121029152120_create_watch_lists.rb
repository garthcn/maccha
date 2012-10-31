class CreateWatchLists < ActiveRecord::Migration
  def change
    create_table :watch_lists do |t|
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
  end
end

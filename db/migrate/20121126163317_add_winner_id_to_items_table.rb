class AddWinnerIdToItemsTable < ActiveRecord::Migration
  def change
    add_column :items, :winner_id, :integer
  end
end

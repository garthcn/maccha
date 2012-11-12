class AddSoldFlagToItem < ActiveRecord::Migration
  def change
    add_column :items, :is_sold, :boolean
  end
end

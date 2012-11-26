class AddIsSoldToItems < ActiveRecord::Migration
  def change
    add_column :items, :is_sold, :boolean
  end
end

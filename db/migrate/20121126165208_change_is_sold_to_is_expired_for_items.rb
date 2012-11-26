class ChangeIsSoldToIsExpiredForItems < ActiveRecord::Migration
  def change
    rename_column :items, :is_sold, :is_expired
  end
end

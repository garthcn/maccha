class AddColsToItems < ActiveRecord::Migration
  def change
    add_column :items, :delete_request, :boolean
    add_column :items, :delete_reason, :text
  end
end

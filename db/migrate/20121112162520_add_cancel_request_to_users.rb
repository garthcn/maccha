class AddCancelRequestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cancel_request, :boolean
    add_column :users, :cancel_reason, :text
  end
end

class AddDeactivatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deactivated, :boolean
  end
end

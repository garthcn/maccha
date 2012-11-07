class AddMoreColumnToBids < ActiveRecord::Migration
  def change
    add_column :bids, :expired_at, :datetime
    add_column :bids, :status, :integer
  end
end

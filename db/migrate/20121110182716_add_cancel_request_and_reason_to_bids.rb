class AddCancelRequestAndReasonToBids < ActiveRecord::Migration
  def change
    add_column :bids, :cancel_request, :boolean
    add_column :bids, :cancel_reason, :text
  end
end

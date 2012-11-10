class ChangeColumnNameInBillingTable < ActiveRecord::Migration
  def change
    rename_column :billings, :cc, :credit_card
  end
end

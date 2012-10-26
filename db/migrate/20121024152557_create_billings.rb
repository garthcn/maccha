class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.integer :user_id
      t.string :cc
      t.string :paypal
      t.text :billing_addr
      t.text :shipping_addr

      t.timestamps
    end
  end
end

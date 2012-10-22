class CreateUserTypes < ActiveRecord::Migration
  def change
    create_table :user_types do |t|
      t.integer :user_id
      t.integer :buyer_type
      t.integer :seller_type

      t.timestamps
    end

    add_index :user_types, :user_id 
  end
end

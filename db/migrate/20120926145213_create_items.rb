class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.float :price
      t.datetime :start_time
      t.datetime :end_time
      t.string :condition
      t.string :location
      t.text :description
      t.integer :seller_id

      t.timestamps
    end
  end
end

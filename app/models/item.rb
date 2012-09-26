class Item < ActiveRecord::Base
  attr_accessible :category, :condition, :description, :end_time, :location, :name, :price, :seller_id, :start_time
end

class Item < ActiveRecord::Base
  attr_accessible :category, :condition, :description, :end_time, :location, :name, :price, :seller_id, :start_time

  attr_accessible :picture
  has_attached_file :picture, :styles => { :medium => "500x500>", :thumb => "100x100>" }

  validates :name, 
    :presence => true,
    :length => { :maximum => 50 }
  validates :price, 
    :presence => true,
    :numericality => { :greater_than => 0, :less_than => 99999999 }
  validates :condition, 
    :presence => true,
    :length => { :maximum => 50 }
  validates :description, 
    :presence => true,
    :length => { :maximum => 1000 }
end

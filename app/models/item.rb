class Item < ActiveRecord::Base
  attr_accessible :category, :condition, :description, :location, :name, :price, :seller_id 
  attr_accessible :start_time, :end_time

  attr_accessible :picture
  has_attached_file :picture, :styles => { :medium => "500x500>", :small => "300x300", :thumb => "100x100>" }, :default_url => "missing.png"
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

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['name LIKE ? OR description LIKE ? ' +
         'OR category LIKE ? OR condition LIKE ? OR location LIKE ? ',
         search_condition, search_condition, search_condition,
         search_condition, search_condition])
  end
  def self.adv_search(search)
    # TODO: advanced search
  end
end

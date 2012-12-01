# == Schema Information
#
# Table name: items
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  category             :string(255)
#  price                :float
#  start_time           :datetime
#  end_time             :datetime
#  condition            :string(255)
#  location             :string(255)
#  description          :text
#  seller_id            :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  is_expired           :boolean
#  is_deleted           :boolean
#  delete_request       :boolean
#  delete_reason        :text
#  winner_id            :integer
#  is_sold              :boolean
#

class Item < ActiveRecord::Base
  attr_accessible :category, :condition, :description, :location, :name, :price, :seller_id 
  attr_accessible :start_time, :end_time
  attr_accessible :delete_request, :delete_reason, :is_deleted

  has_many :bids
  has_many :transactions
  belongs_to :user

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
  validates :category, 
    :presence => true,
    :length => { :maximum => 100 }

  def self.search(search, page, items_per_page)
    if search.nil? or search.empty?
      offset = (page - 1) * items_per_page
      [
        find(:all, :offset => offset, :limit => items_per_page, 
             :order => 'id ASC'),
        count(:all)
      ]
    else
      search_condition = "%" + search + "%"
      # page = page.to_i
      # items_per_page = items_per_page.to_i
      offset = (page - 1) * items_per_page
      conditions = ['name LIKE ? OR description LIKE ? ' +
        'OR category LIKE ? OR condition LIKE ? OR location LIKE ? ',
        search_condition, search_condition, search_condition,
        search_condition, search_condition]

      [
        find(:all, :offset => offset, :limit => items_per_page, 
             :order => 'id ASC', :conditions => conditions),
        count(:all, :conditions => conditions)
      ]
    end
  end

  def self.adv_search(search)
    # TODO: advanced search
  end

  def picture_url
    self.picture.url.to_s
  end

  def expired?
    Time.now > self.end_time ? true : false
  end
end

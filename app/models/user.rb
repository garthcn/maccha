class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable,:token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body
  has_many :items
  validates_uniqueness_of :email, 
    :case_sensitive => false, 
    :allow_blank => false, 
    :if => :email_changed?
  validates_format_of :email, 
    :with  => Devise.email_regexp, 
    :allow_blank => false, 
    :if => :email_changed?
  validates_presence_of :password, 
    :on => :create
  validates_confirmation_of :password, 
    :on => :create
  validates_length_of :password, 
    :within => 6..128, 
    :allow_blank => false

  has_one :user_type
  has_one :billing
	has_many :items
  has_many :watch_lists

  def watching?(item)
    self.watch_lists.find_by_item_id(item.id)
  end
  
end

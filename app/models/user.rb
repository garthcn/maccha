# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  request_to_leave       :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable,:token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
									:remember_me, :name, :cancel_request, :cancel_reason, :deactivated
  # attr_accessible :title, :body
  
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
    :within => 6..128
	validates_acceptance_of :delete_request_agree

  has_many :items , :foreign_key => 'seller_id'
  has_many :bids, :foreign_key => 'buyer_id'
  has_many :transactions, :foreign_key => 'buyer_id'
  has_many :watch_lists

  has_one :user_type
  has_one :billing

  def watching?(item)
    self.watch_lists.find_by_item_id(item.id)
  end

  def items_for_sale
    Item.find(:all, :conditions => { :seller_id => self.id })
  end
  
end

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
#  cancel_request         :boolean
#  cancel_reason          :text
#  deactivated            :boolean
#

require 'spec_helper'

#describe User do

  #describe "user attributes" do
    #before { 
      #@user = User.create(name: "andrew", email: "andrew@cmu.edu") 
    #}
    #subject { @user }

    #it { should respond_to(:name) }
    #it { should respond_to(:email) }
    #it { should respond_to(:encrypted_password) }
  #end

  #describe "user account management" do
  
  #end

#end


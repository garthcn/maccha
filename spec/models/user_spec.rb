require 'spec_helper'

describe User do

  describe "user attributes" do
    before { 
      @user = User.create(name: "andrew", email: "andrew@cmu.edu") 
    }
    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:encrypted_password) }
  end

  describe "user account management" do
  
  end

end


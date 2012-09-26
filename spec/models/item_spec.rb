require 'spec_helper'

describe Item do

  describe "item attributes" do
    before { 
      @item = Item.create(name: "iPhone", category: "phone") 
    }
    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:encrypted_password) }
  end

  describe "item CRUD" do
  
  end

end



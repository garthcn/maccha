require 'spec_helper'

describe Item do

  before(:each) do
    @attr = {
      :name => "iPhone 7",
      :category => "Electronics",
      :price =>  "10.0",
      :start_time => DateTime.new(2012,12,24,11,59,00),
      :end_time => DateTime.new(2012,12,24,11,59,00),
      :condition => "like new",
      :location => "Pittsburgh",
      :description => "android is better",
      :seller_id => "1"
    }
  end

  describe "item attributes" do
    it "should have correct attributes" do

      @item = Item.create(@attr)

      @item.name.should == 'iPhone 7'
      @item.category.should == 'Electronics'
      @item.location.should == 'Pittsburgh'
    end
  end

  describe "item info validation" do
    it "should not create if price is not valid" do
      @attr[:price] = -3
      item = Item.new(@attr)
      item.save.should == false
    end

    it "should not create if name is missing" do
      @attr[:name] = ''
      item = Item.new(@attr)
      item.save.should == false
    end

    it "should not create if category is missing" do
      @attr[:category] = ''
      item = Item.new(@attr)
      item.save.should == false
    end
  end
  describe "item CRUD" do
    it "should create an item" do
      Item.create(@attr)
      @item = Item.find_by_name('iPhone 7')
      @item.should_not be_blank
      @item.description.should == 'android is better'
    end

    it "should update an item attribute" do
      @item = Item.create(@attr)
      @attr[:name] = 'iPhone 3G'
      @item.update_attributes(@attr)
      @item.name.should == 'iPhone 3G'
    end

    it "should delete an item" do
      @item = Item.create(@attr)
      @item.destroy
      Item.find_by_name('iPhone 7').should be_blank 
    end
  end

end

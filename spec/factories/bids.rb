# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bid do
    seller_id 1
    buyer_id 1
    item_id 1
    price 10
    bid_time
  end
end

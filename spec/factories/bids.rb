# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bid do
    seller_id 1
    buyer_id 1
    item_id 1
    amount 1.5
    bid_time "2012-10-22 11:50:30"
  end
end

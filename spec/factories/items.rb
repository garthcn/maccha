# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "iPhone"
    category "Electronics"
    price "10.0"
    start_time Date.today
    end_time Date.tomorrow
    condition "like new"
    location "Pittsburgh"
    description "android is better"
    seller_id "1"
  end
end

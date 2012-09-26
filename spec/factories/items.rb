# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "iPhone"
    category "Electronics"
    price "10.0"
    start_time "2012-08-26 10:52:13"
    end_time "2012-09-26 10:52:13"
    condition "like new"
    location "Pittsburgh"
    description "android is better"
    seller_id "1"
  end
end

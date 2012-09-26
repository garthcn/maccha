# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "MyString"
    category "MyString"
    price 1.5
    start_time "2012-09-26 10:52:13"
    end_time "2012-09-26 10:52:13"
    condition "MyString"
    location "MyString"
    description "MyText"
    seller_id 1
  end
end

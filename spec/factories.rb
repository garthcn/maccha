FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :item do
    name "iPhone"
    category "Electronics"
    price "10.0"
    start_time DateTime.new(2012,12,24,11,59,00)
    end_time DateTime.new(2012,12,24,11,59,00)
    condition "like new"
    location "Pittsburgh"
    description "android is better"
    seller_id "1"
  end
end

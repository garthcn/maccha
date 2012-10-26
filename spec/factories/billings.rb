# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :billing do
    user_id 1
    cc "MyString"
    paypal "MyString"
    billing_addr "MyText"
    shipping_addr "MyText"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "jiasi"
    password "111111"
    email "jiasi@cmu.edu"
    confirmed_at Time.now - 1.hour
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Test Test"
    password "aaaaaaaa"
    email "glory791days@gmail.com"
    #confirmed_at Time.now - 1.hour
  end
end

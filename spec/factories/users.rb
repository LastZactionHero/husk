# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "user@company.com"
    password "helloworld"
  end
end

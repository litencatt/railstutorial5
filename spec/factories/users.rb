# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Michael Example"
    email "michael@example.com"
    password "password"
  end

end

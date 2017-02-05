# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Michael Example"
    email "michael@example.com"
    password "password"

    factory :other do
      name "Sterling Archer"
      email "duchess@example.gov"
    end
  end

end

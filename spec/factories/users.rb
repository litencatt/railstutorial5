# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Example User"
    sequence(:email) {|n| "user#{n}@example.com" }
    password              'foobar'
    password_confirmation 'foobar'
  end

end

# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :micropost do
    content "MyText"
    user_id 1
  end
end

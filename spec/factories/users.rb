FactoryBot.define do
  factory :user do
    first_name { "Normal " }
    last_name { "User" }
    sequence(:email) { |n| "normal_user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end

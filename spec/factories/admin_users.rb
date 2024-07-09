FactoryBot.define do
  factory :admin_user do
    first_name { "Admin" }
    last_name { "User" }
    sequence(:email) { |n| "admin_user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    role { "admin" }
  end
end

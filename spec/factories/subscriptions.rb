FactoryBot.define do
  factory :subscription do
    endpoint { "MyString" }
    p256dh { "MyString" }
    auth { "MyString" }
    user { nil }
  end
end

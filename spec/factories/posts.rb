FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    read_count { 0 }
    approved_by_admin { false }
    association :user
  end
end
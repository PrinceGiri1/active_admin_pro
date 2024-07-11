FactoryBot.define do
  factory :payment do
    amount { 1 }
    razorpay_payment_id { "MyString" }
  end
end

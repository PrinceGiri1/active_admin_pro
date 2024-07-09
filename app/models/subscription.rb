class Subscription < ApplicationRecord
  belongs_to :user, optional: true

  validates :endpoint, :p256dh, :auth, presence: true
end

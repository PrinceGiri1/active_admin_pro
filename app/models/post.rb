class Post < ApplicationRecord
	belongs_to :user, optional: true
	has_many :comments, dependent: :destroy
  after_create :send_notification

  def self.ransackable_attributes(auth_object = nil)
    %w[title description approved_by_admin read_count body created_at updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[comments user]
  end

  scope :unpublished, -> { where(approved_by_admin: true) }

  def send_notification
    subscriptions = Subscription.all
    subscriptions.each do |subscription|
      message = "New Post Created: #{self.title}"
      PushNotificationService.new(subscription, message).send_notification
    end
  end
end

class PushNotificationService
  def initialize(subscription, message)
    @subscription = subscription
    @message = message
  end

  def send_notification
    WebPush.payload_send(
      message: @message,
      endpoint: @subscription.endpoint,
      p256dh: @subscription.p256dh,
      auth: @subscription.auth,
      vapid: WEBPUSH_VAPID_OPTIONS
    )
  end
end

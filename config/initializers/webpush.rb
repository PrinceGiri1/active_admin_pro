WEBPUSH_VAPID_OPTIONS = {
  public_key: Rails.application.credentials.dig(:webpush, :public_key),
  private_key: Rails.application.credentials.dig(:webpush, :private_key),
  subject: 'mailto:your-email@example.com'
}

class TwilioService
  def initialize
    @client = Twilio::REST::Client.new(
      Rails.application.credentials.twilio[:account_sid],
      Rails.application.credentials.twilio[:auth_token]
    )
  end

  def send_sms(to:, body:)
    @client.messages.create(
      from: Rails.application.credentials.twilio[:phone_number],
      to: to,
      body: body
    )
  end
end
# TwilioService.new.send_sms('917991577204', "this is test done by prince") this is worng becouse send_sms have keyword arrgument so do like
# TwilioService.new.send_sms(to: '917991577204', body: "this is test done by prince")

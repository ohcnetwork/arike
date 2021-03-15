Twilio.configure do |config|
  config.account_sid = ENV["TWILIO_ACCOUNT_SENDER_ID"]
  config.auth_token = ENV["TWILIO_AUTH_TOKEN"]
end

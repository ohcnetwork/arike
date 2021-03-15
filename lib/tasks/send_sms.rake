desc "Send an SMS using the Twilio API service"
task :send_sms => [:environment] do
  User.first.send_sms
end

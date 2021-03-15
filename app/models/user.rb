class User < ApplicationRecord
  ROLES = %w(superuser primary_nurse secondary_nurse)

  validates :role, inclusion: {
    in: ROLES,
    message: "%{value} is not a valid role"
  }

  def send_sms
    auth_token = ENV["TWILIO_AUTH_TOKEN"]
    puts "SMS sending stub"
  end
end

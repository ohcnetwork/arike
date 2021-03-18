class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :patients
  ROLES = %w(superuser primary_nurse secondary_nurse asha volunteer)
  SIGNUP_ROLES = %w(asha volunteer)
  validates :role, inclusion: {
                     in: ROLES,
                     message: "%{value} is not a valid role",
                   }
  scope :ashas, -> { where(role: "asha") }
  scope :volunteers, -> { where(role: "volunteer") }
  # enum roles: ROLES

  def send_sms
    phone_num = ENV["TWILIO_SENDER_NUMBER"]
    puts "SMS sending stub"
    client = Twilio::REST::Client.new()
    to = "" # verified twilio number
    client.messages.create(
      from: phone_num,
      to: to,
      body: "Click here to login: ",
    )
  end

  def self.addVolunteer(patient, params)
    params.each { |key, value|
      if value.to_i == 1
        patient.users << User.find_by_id(key)
      end
    }
  end

  def self.getRole(role)

    case role

    when "primary_nurse"
      return "Primary Nurse"

    when "secondary_nurse"
      return "Secondary Nurse"

    when "asha"
      return "ASHA Member"

    when "volunteer"
      return "Volunteer"

    when "superuser"
      return "Super User"
    end

  end
end

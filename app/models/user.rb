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
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, :on => :create
  validates :email, uniqueness: true
  validates :phone, uniqueness: true

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

  def self.get_role(role)
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

  def self.verified
    User.where(verified: true)
  end

  def self.unverified
    User.where(verified: false)
  end

  def superuser?
    self[:role] == "superuser"
  end
end

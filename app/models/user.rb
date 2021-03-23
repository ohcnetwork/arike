class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :patients # how can user has many patients?
  belongs_to :facilities
  enum roles: {
                superuser: "Superuser",
                primary_nurse: "Primary Nurse",
                secondary_nurse: "Secondary Nurse",
                asha: "ASHA",
                volunteer: "Volunteer",
              }
  SIGNUP_ROLES = [roles[:asha], roles[:volunteer]]
  validates :role, inclusion: {
                     in: roles.values,
                     message: "%{value} is not a valid role",
                   }
  scope :ashas, -> { where(role: roles[:asha]) }
  scope :volunteers, -> { where(role: roles[:volunteer]) }
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

  def self.verified
    User.where(verified: true)
  end

  def self.unverified
    User.where(verified: false)
  end

  def superuser?
    self[:role] == User.roles[:superuser]
  end
end

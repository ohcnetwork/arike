class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :patients # how can user has many patients?
  belongs_to :facility, class_name: "Facility", foreign_key: "facility_id", optional: true, inverse_of: :primary_nurses
  belongs_to :facility, class_name: "Facility", foreign_key: "facility_id", optional: true, inverse_of: :secondary_nurses
  enum roles: {
                superuser: "Superuser",
                medical_officer: "Medical Officer",
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
  scope :primary_nurses, -> { where(role: roles[:primary_nurse]) }
  scope :secondary_nurses, -> { where(role: roles[:secondary_nurse]) }
  scope :nurses, -> { (where(role: [roles[:primary_nurse], roles[:secondary_nurse]])) }
  scope :assignable_users, -> { where("role = ? OR role = ?", "Primary Nurse", "Secondary Nurse").where(facility_id: nil) }

  validates :phone, uniqueness: true

  def send_sms(to, message)
    phone_num = ENV["TWILIO_SENDER_NUMBER"]
    client = Twilio::REST::Client.new()
    client.messages.create(
      from: phone_num,
      to: "+91" + to,
      body: message,
    )
  end

  def self.add_to_facility(user_id, facility_id)
    user = find_by(id: user_id)
    user.facility_id = facility_id
    user
  end

  def self.remove_from_facility(user_id, facility_id)
    user = find_by(id: user_id)
    if user.facility_id == facility_id
      user.facility_id = nil
    end
    user
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

  def primary_nurse?
    self[:role] == User.roles[:primary_nurse]
  end

  def secondary_nurse?
    self[:role] == User.roles[:secondary_nurse]
  end

  def nurse?
    self[:role] == User.roles[:primary_nurse] || self[:role] == User.roles[:secondary_nurse]
  end

  def medical_officer?
    self[:role] == User.roles[:medical_officer]
  end

  def facility_access?
    [User.roles[:superuser], User.roles[:medical_officer], User.roles[:primary_nurse], User.roles[:secondary_nurse]].include? self[:role]
  end

  def facility
    Facility.find_by(id: facility_id)
  end
end

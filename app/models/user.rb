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
  scope :assignable_users, -> { where(role: roles[:primary_nurse]).or(where(role: roles[:secondary_nurse])).where(facility_id: nil) }
  scope :verified, -> { where(verified: true) }
  scope :unverified, -> { where(verified: true) }
  
  validates :phone, uniqueness: true

  attr_accessor :login_id

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if  login = conditions.delete(:login_id)
      where(conditions.to_h).where(phone: login.to_i).or(where(email: login.downcase)).first
    elsif conditions.has_key?(:email) || conditions.has_key?(:phone)
      find_by(conditions.to_h)
    end
  end

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

  def nurse?
    primary_nurse? || secondary_nurse?
  end

  def facility_access?
    [User.roles[:superuser], User.roles[:medical_officer], User.roles[:primary_nurse], User.roles[:secondary_nurse]].include? self[:role]
  end

  def facility
    Facility.find_by(id: facility_id)
  end
end

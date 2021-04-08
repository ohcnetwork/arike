class Facility < ApplicationRecord
  has_many :patients, dependent: :restrict_with_error
  has_many :primary_facilities, class_name: "Facility", foreign_key: "parent_id", inverse_of: :facility, dependent: :restrict_with_error
  belongs_to :secondary_facility, class_name: "Facility", optional: true, foreign_key: "parent_id", inverse_of: :facility
  has_many :primary_nurses, -> { where(role: User.roles[:primary_nurse]) }, class_name: "User", foreign_key: "facility_id", inverse_of: :facility
  has_many :secondary_nurses, -> { where(role: User.roles[:secondary_nurse]) }, class_name: "User", foreign_key: "facility_id", inverse_of: :facility
  belongs_to :lsg_body_info, class_name: "LsgBody", foreign_key: "lsg_body_id", inverse_of: :facilities
  belongs_to :ward_info, class_name: "Ward", foreign_key: "ward_id", inverse_of: :facilities

  scope :secondary_facilities, -> { where(parent_id: nil) }
  scope :primary_facilities, -> { where.not(parent_id: nil) }
  belongs_to :ward

  enum kinds: {
    primary: "PHC",
    secondary: "CHC",
    hospital: "Hospital",
  }

  validates :parent_id, presence: true, if: -> { kind == Facility.kinds[:primary] }
  validates :parent_id, absence: true, if: -> { kind == Facility.kinds[:secondary] }

  def secondary_facility?
    parent_id == nil
  end

  def primary_facility?
    !secondary_facility?
  end
end

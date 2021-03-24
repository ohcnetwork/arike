class Facility < ApplicationRecord
  has_many :patients
  has_many :primary_facilities, class_name: "Facility", foreign_key: "parent_id"
  belongs_to :secondary_facility, class_name: "Facility", optional: true, foreign_key: "parent_id"
  has_many :primary_nurses, through: :primary_facilities
  has_many :secondary_nurses, through: :secondary_facility

  validates :parent_id, presence: true, if: -> { kind == "PHC" }
  validates :parent_id, absence: true, if: -> { kind == "CHC" }

  def self.secondary_facilities
    Facility.where(parent_id: nil)
  end

  def secondary_facility?
    parent_id == nil
  end

  def primary_facility?
    parent_id != nil
  end
end

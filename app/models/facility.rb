class Facility < ApplicationRecord
  has_many :patients
  has_many :primary_facilities, class_name: 'Facility', foreign_key: 'parent_id'
  belongs_to :secondary_facility,
             class_name: 'Facility',
             optional: true,
             foreign_key: 'parent_id'
  has_many :primary_nurses,
           -> { where('role = ?', 'Primary Nurse') },
           class_name: 'User',
           foreign_key: 'facility_id'
  has_many :secondary_nurses,
           -> { where('role = ?', 'Secondary Nurse') },
           class_name: 'User',
           foreign_key: 'facility_id'
  belongs_to :lsg_body_info, class_name: 'LsgBody', foreign_key: 'lsg_body'
  belongs_to :ward_info, class_name: 'Ward', foreign_key: 'ward'

  # has_many :users, -> { where("role = ? OR role = ? OR role = ?", "Primary Nurse", "Secondary Nurse", "Superuser") }

  validates :parent_id, presence: true, if: -> { kind.in? ['PHC'] }
  validates :parent_id, absence: true, if: -> { kind.in? ['CHC'] }
  belongs_to :ward

  def self.secondary_facilities
    Facility.where(parent_id: nil)
  end

  def secondary_facility?
    parent_id == nil
  end

  def primary_facility?
    !secondary_facility?
  end
end

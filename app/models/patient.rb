class Patient < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :family_details
  belongs_to :facilities

  def add_users(user_ids)
    user_ids.each do |user_id|
      self.users << User.find_by_id(user_id)
    end
  end

  def self.get_ward(patient)
    facility = Facility.find(patient.facility_id)
    Ward.find(facility.ward)
  end
end

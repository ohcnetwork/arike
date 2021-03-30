class Patient < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :family_details
  belongs_to :facility

  def add_users(user_ids)
    user_ids.each do |user_id|
      self.users << User.find_by_id(user_id)
    end
  end

  def update_users(user_ids)
    self.users = []
    user_ids.each do |user_id|
      self.users << User.find_by_id(user_id)
    end
  end

  def self.get_ward(patient)
    facility = Facility.all.find_by_id(patient.facility_id)
    Ward.find(facility.ward)
  end

  def update_family_member(family_details_params, patient_id)
    self.family_details.destroy_all
    family_details_params.values.each { |details|
      details[:patient_id] = patient_id
      family_member = FamilyDetail.create!(details)
      self.family_details << family_details
    }
  end
end

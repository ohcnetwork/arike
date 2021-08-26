class Patient < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :family_details, dependent: :destroy
  has_many :patient_disease_summaries, dependent: :destroy
  has_many :patient_treatments, dependent: :destroy
  belongs_to :facility
  validates :full_name, presence: true, length: { minimum: 1 }
  validates :phone, :emergency_phone_no, :presence => { :message => "Invalid Phone Number" },
                                         :numericality => true,
                                         :length => { :minimum => 10, :maximum => 15 }

  enum economic_status: {
    well_of: "Well Off",
    middle_class: "Middle Class",
    poor: "Poor",
    very_poor: "Very Poor",
  }

  def add_users(user_ids)
    user_ids.each do |user_id|
      self.users << User.find(user_id)
    end
  end

  def update_users(user_ids)
    self.users = []
    user_ids.each do |user_id|
      self.users << User.find_by(id: user_id)
    end
  end

  def self.get_ward(patient)
    patient.facility.ward
  end

  def update_family_member(family_details_params, patient_id)
    self.family_details.destroy_all
    family_details_params.values.each { |details|
      details[:patient_id] = patient_id
      FamilyDetail.create!(details)
    }
  end

  def update_disease_history(disease_history, patient_id)
    self.patient_disease_summaries.destroy_all
    disease_history.values.each { |details|
      details[:patient_id] = patient_id
      PatientDiseaseSummary.create!(details)
    }
  end

  def add_treatments(treatments)
    treatments.values.each { |details|
      details[:patient_id] = self.id
      PatientTreatment.create!(details)
    }
  end
end

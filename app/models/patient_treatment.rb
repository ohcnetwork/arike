class PatientTreatment < ApplicationRecord
  belongs_to :patient
  validates :name,
            inclusion: {
              in: Treatment.all.map { |d| d.name }.to_a,
              message: '%{value} is not a valid treatment',
            }
  validates :category,
            inclusion: {
              in: Treatment.all.map { |d| d.category }.to_a,
              message: '%{value} is not a valid category',
            }
end

class PatientDiseaseSummary < ApplicationRecord
  belongs_to :patient
  validates :name, inclusion: { in: Disease.all.map { |d| d.id }.to_a,
                        message: "%{value} is not a valid disease" }
end

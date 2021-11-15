class Treatment < ApplicationRecord
  def self.available_treatments(patient)
    Treatment.all.select do |treatment|
      !patient
        .patient_treatments
        .active_treatments
        .pluck(:name)
        .include?(treatment.name)
    end
  end
end

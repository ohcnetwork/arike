class AddDescriptionToPatientTreatments < ActiveRecord::Migration[6.1]
  def change
    add_column :patient_treatments, :description, :text
  end
end

class CreatePatientTreatments < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_treatments, id: :uuid do |t|
      t.uuid :patient_id
      t.string :category
      t.string :name
      t.datetime :stopped_at

      t.timestamps
    end
  end
end

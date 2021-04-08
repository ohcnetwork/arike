class CreatePatientDiseaseSummary < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_disease_summaries, id: :uuid do |t|
      t.uuid :patient_id
      t.uuid :name
      t.string :date_of_diagnosis
      t.string :investigation
      t.string :treatments
      t.string :remarks

      t.timestamps
    end
  end
end

class CreateVisitDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :visit_details, id: :uuid do |t|
      t.uuid :general_health_information_id
      t.uuid :psychological_review_id
      t.uuid :physical_symptoms_id
      t.uuid :physical_examination_id
      t.uuid :patient_id

      t.timestamps
    end
  end
end

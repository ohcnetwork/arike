class CreatePhysicalSymptoms < ActiveRecord::Migration[6.1]
  def change
    create_table :physical_symptoms, id: :uuid do |t|
      t.uuid :visit_id
      t.string :patient_at_peace
      t.string :pain
      t.string :shortness_breath
      t.string :weakness
      t.string :poor_mobility
      t.string :nausea
      t.string :vomiting
      t.string :poor_appetite
      t.string :constipation
      t.string :sore
      t.string :drowsiness
      t.string :wound
      t.string :lack_of_sleep
      t.string :micnutrition
      t.string :other_symptoms

      t.timestamps
    end
  end
end

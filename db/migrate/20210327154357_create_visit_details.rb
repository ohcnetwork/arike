class CreateVisitDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :visit_details, id: :uuid do |t|
      t.integer :AKPS
      t.text :disease_history_changed
      t.string :palliative_phase
      t.string :patient_worried
      t.string :family_anxious
      t.string :patient_depressed
      t.string :patient_feels
      t.string :patient_informed
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
      t.string :micturition
      t.text :other_symptoms
      t.float :bp
      t.float :grbs
      t.float :rr
      t.float :pulse
      t.text :personal_hygiene
      t.text  :mouth_hygiene
      t.text :pubic_hygiene
      t.string :systemic_examination
      t.text :systemic_examination_details
      t.text :done_by
      t.timestamps
    end
  end
end

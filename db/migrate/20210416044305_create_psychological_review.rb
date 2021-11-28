class CreatePsychologicalReview < ActiveRecord::Migration[6.1]
  def change
    create_table :psychological_reviews, id: :uuid do |t|
      t.uuid :visit_id
      t.string :patient_worried
      t.string :family_anxious
      t.string :patient_depressed
      t.string :patient_feels
      t.string :patient_informed

      t.timestamps
    end
  end
end

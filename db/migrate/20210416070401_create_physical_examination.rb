class CreatePhysicalExamination < ActiveRecord::Migration[6.1]
  def change
    create_table :physical_examinations, id: :uuid do |t|
      t.uuid :visit_id
      t.string :bp
      t.string :grbs
      t.string :rr
      t.string :pulse
      t.string :personal_hygiene
      t.string :mouth_hygiene
      t.string :pubic_hygiene
      t.string :systemic_examination
      t.string :systemic_examination_details
      t.uuid :done_by

      t.timestamps
    end
  end
end

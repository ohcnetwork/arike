class CreateFamilyDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :family_details, id: :uuid do |t|
      t.uuid :patient_id
      t.string :full_name
      t.string :phone
      t.date :dob
      t.string :relation
      t.string :address

      t.timestamps
    end
  end
end

class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients, id: :uuid do |t|
      t.string :first_name
      t.string :full_name
      t.date :dob

      t.timestamps
    end
  end
end

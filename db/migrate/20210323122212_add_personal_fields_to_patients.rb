class AddPersonalFieldsToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :sex, :string
    add_column :patients, :emergency_phone_no, :string
    add_column :patients, :disease, :string
  end
end

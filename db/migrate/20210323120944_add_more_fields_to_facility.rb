class AddMoreFieldsToFacility < ActiveRecord::Migration[6.1]
  def change
    # add facility_id to patients
    add_reference :patients, :facility, type: :uuid, index: true
    # add facility_id to users
    add_reference :users, :facility, type: :uuid, index: true
    # link facility to facility
    add_reference :facilities, :parent, type: :uuid, foreign_key: { to_table: :facilities }
  end
end

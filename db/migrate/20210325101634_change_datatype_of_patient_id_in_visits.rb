class ChangeDatatypeOfPatientIdInVisits < ActiveRecord::Migration[6.1]
  def change
    remove_column :visits, :patient_id
    remove_column :visits, :user_id
    add_column :visits, :patient_id, :uuid
    add_column :visits, :user_id, :uuid
  end
end

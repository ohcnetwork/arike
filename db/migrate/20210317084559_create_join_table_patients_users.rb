class CreateJoinTablePatientsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :patients_users do |t|
      t.uuid :patient_id
      t.uuid :user_id
      # t.index [:patient_id, :user_id]
      # t.index [:user_id, :patient_id]
    end
  end
end

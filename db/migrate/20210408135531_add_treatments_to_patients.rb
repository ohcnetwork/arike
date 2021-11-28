class AddTreatmentsToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :treatment, :json
  end
end

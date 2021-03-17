class AddReportedToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :reported_by, :uuid
    add_column :patients, :created_by, :uuid
  end
end

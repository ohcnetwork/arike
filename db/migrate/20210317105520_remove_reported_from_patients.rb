class RemoveReportedFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :reported_by, :bigint
    remove_column :patients, :created_by, :bigint
  end
end

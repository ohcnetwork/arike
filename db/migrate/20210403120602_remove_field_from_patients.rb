class RemoveFieldFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :reported_by, :uuid
  end
end

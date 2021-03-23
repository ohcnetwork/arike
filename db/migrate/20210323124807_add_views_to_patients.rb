class AddViewsToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :patient_views, :string
    add_column :patients, :family_views, :string
  end
end

class AddStateDistrictToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :state, :string
    add_column :patients, :district, :string
  end
end

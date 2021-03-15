class AddFieldsToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :address, :string
    add_column :patients, :route, :string
    add_column :patients, :phone, :string
    add_column :patients, :economic_status, :string
    add_column :patients, :notes, :string
  end
end

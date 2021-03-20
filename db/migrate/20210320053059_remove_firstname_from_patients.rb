class RemoveFirstnameFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :first_name, :string
  end
end

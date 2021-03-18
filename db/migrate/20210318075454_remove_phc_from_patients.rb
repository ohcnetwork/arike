class RemovePhcFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :phc, :bigint
  end
end

class RenameColumnsInPatients < ActiveRecord::Migration[6.1]
  def change
    rename_column :patients, :sex, :gender
  end
end

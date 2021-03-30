class RenameColumnsInFacilities < ActiveRecord::Migration[6.1]
  def change
    rename_column :facilities, :ward, :ward_id
    rename_column :facilities, :lsg_body, :lsg_body_id
  end
end

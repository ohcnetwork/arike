class RemoveMemberFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :aasha_member, :bigint
    remove_column :patients, :volunteer, :bigint
  end
end

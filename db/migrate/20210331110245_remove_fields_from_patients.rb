class RemoveFieldsFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :asha_member, :uuid
    remove_column :patients, :lsg_body, :uuid
  end
end

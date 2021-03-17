class AddAshaMemberToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :asha_member, :uuid
  end
end

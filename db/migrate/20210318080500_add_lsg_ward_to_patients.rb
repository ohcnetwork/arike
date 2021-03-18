class AddLsgWardToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :lsg_body, :uuid
  end
end

class AddArchivedByToLsgBodies < ActiveRecord::Migration[6.1]
  def change
    add_column :lsg_bodies, :archived_by, :string
  end
end

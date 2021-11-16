class AddArchivedToLsgBodies < ActiveRecord::Migration[6.1]
  def change
    add_column :lsg_bodies, :archived, :boolean, default: false
  end
end

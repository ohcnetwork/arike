class RenameDistrictsColumnAndIndexInLsgBodies < ActiveRecord::Migration[6.1]
  def change
    rename_index :lsg_bodies,
                 'index_lsg_bodies_on_districts_id',
                 'index_lsg_bodies_on_district_id'
    rename_column :lsg_bodies, :districts_id, :district_id
  end
end

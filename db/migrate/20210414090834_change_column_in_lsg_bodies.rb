class ChangeColumnInLsgBodies < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:lsg_bodies, :district_id, false)
  end
end

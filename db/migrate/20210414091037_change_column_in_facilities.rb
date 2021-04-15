class ChangeColumnInFacilities < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:facilities, :district_id, false)
    change_column_null(:facilities, :state_id, false)
  end
end

class ChangeColumnInFacility < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:facilities, :kind, false)
    change_column_null(:facilities, :name, false)
    change_column_null(:facilities, :state, false)
    change_column_null(:facilities, :district, false)
    change_column_null(:facilities, :lsg_body_id, false)
    change_column_null(:facilities, :ward_id, false)
    change_column_null(:facilities, :pincode, false)
    change_column_null(:facilities, :phone, false)
    add_index :facilities, :phone, :unique => true
  end
end

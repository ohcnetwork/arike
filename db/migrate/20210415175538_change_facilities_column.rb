class ChangeFacilitiesColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:facilities, :address, false)
  end
end

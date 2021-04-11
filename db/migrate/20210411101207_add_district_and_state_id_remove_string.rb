class AddDistrictAndStateIdRemoveString < ActiveRecord::Migration[6.1]
  def change
    remove_column :facilities, :state, :string
    remove_column :facilities, :district, :string
    add_reference :facilities, :state, foreign_key: true, type: :uuid
    add_reference :facilities, :district, foreign_key: true, type: :uuid
  end
end

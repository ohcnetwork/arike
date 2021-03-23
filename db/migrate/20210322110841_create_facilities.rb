class CreateFacilities < ActiveRecord::Migration[6.1]
  def change
    create_table :facilities, id: :uuid do |t|
      t.string :kind
      t.string :name
      t.string :state
      t.string :district
      t.uuid :lsg_body
      t.uuid :ward
      t.string :address
      t.bigint :pincode
      t.bigint :phone

      t.timestamps
    end
  end
end

class CreateGeneralHealthInformation < ActiveRecord::Migration[6.1]
  def change
    create_table :general_health_informations, id: :uuid do |t|
      t.uuid :visit_id
      t.string :akps
      t.string :palliative_phase

      t.timestamps
    end
  end
end

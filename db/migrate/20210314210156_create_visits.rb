class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits, id: :uuid do |t|
      t.datetime :date
      t.references :patient
      t.references :user

      t.timestamps
    end
  end
end

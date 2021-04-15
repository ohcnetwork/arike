class CreateDistricts < ActiveRecord::Migration[6.1]
  def change
    create_table :districts, id: :uuid do |t|
      t.string :name
      t.references :states, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

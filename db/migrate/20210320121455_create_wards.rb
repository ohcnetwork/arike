class CreateWards < ActiveRecord::Migration[6.1]
  def change
    create_table :wards, id: :uuid do |t|
      t.string :name
      t.bigint :number
      t.references :lsg_body, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

class CreateTreatment < ActiveRecord::Migration[6.1]
  def change
    create_table :treatments, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :full_name
      t.string :role

      t.timestamps
    end
  end
end

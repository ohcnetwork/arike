class CreateLsgBody < ActiveRecord::Migration[6.1]
  def change
    create_table :lsg_bodies, id: :uuid do |t|
      t.string :name
      t.string :kind

      t.timestamps
    end
  end
end

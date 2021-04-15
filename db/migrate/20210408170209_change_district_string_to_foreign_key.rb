class ChangeDistrictStringToForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_column :lsg_bodies, :district, :string
    add_reference :lsg_bodies, :districts, foreign_key: true, type: :uuid
  end
end

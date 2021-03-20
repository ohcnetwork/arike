class AddCodeAndDistrictToLsgBodies < ActiveRecord::Migration[6.1]
  def change
    add_column :lsg_bodies, :code, :string
    add_column :lsg_bodies, :district, :string
  end
end

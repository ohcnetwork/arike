class RemoveLsgWardFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :lsg_ward, :bigint
  end
end

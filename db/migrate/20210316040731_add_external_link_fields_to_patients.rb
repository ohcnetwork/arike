class AddExternalLinkFieldsToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :lsg_ward, :bigint
    add_column :patients, :aasha_member, :bigint
    add_column :patients, :volunteer, :bigint
    add_column :patients, :phc, :bigint
    add_column :patients, :reported_by, :bigint
    add_column :patients, :created_by, :bigint
  end
end

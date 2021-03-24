class AddFieldsToFamilyDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :family_details, :education, :string
    add_column :family_details, :occupation, :string
    add_column :family_details, :remarks, :string
  end
end

# add_column <table name> <field_name> jsonb, default[]

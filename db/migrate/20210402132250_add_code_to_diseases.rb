class AddCodeToDiseases < ActiveRecord::Migration[6.1]
  def change
    add_column :diseases, :icds_code, :string
  end
end

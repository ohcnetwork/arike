class AddCategoryToTreatment < ActiveRecord::Migration[6.1]
  def change
    add_column :treatments, :category, :string
  end
end

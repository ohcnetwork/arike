class AddFieldsToVisits < ActiveRecord::Migration[6.1]
  def change
    add_column :visits, :first_visit, :datetime
    add_column :visits, :last_visit, :datetime
    add_column :visits, :records, :json
  end
end

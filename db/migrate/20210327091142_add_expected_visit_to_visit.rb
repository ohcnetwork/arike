class AddExpectedVisitToVisit < ActiveRecord::Migration[6.1]
  def change
    add_column :visits, :expected_visit, :datetime
  end
end

class AddNextVisitToVisits < ActiveRecord::Migration[6.1]
  def change
    add_column :visits, :next_visit, :datetime
  end
end

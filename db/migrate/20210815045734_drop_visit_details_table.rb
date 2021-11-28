class DropVisitDetailsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :visit_details
  end
end

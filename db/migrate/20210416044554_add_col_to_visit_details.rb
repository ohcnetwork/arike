class AddColToVisitDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :visit_details, :general_health_information_id, :uuid
    add_column :visit_details, :psychological_review_id, :uuid
  end
end

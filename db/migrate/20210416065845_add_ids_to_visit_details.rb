class AddIdsToVisitDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :visit_details, :physical_symptoms_id, :uuid
    add_column :visit_details, :physical_examination_id, :uuid
  end
end

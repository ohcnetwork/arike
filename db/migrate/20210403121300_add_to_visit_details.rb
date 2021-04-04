class AddToVisitDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :visit_details, :assigned_to_specialist_nurse, :bool, default:false
    add_column :visit_details, :assigned_to_primary_nurse, :bool, default:false
    add_column :visit_details, :assigned_to_physiotherapist, :bool, default:false
    add_column :visit_details, :is_doctor_accompanying, :bool, default:false
  end
end

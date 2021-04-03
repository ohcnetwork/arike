class RenamePatientVitalsColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :visit_details, :AKPS, :akps
    rename_column :visit_details, :poor_Appetite, :poor_appetite
  end
end

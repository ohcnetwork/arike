class RenamePatientVitalsColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :visit_details, :AKPS, :akps
  end
end

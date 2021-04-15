class RenameDistrictsIdColumnAndIndex < ActiveRecord::Migration[6.1]
  def change
    rename_index :districts,
                 'index_districts_on_states_id',
                 'index_districts_on_state_id'
    rename_column :districts, :states_id, :state_id
  end
end

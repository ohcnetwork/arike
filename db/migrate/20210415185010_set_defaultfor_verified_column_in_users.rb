class SetDefaultforVerifiedColumnInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :verified, :boolean, :default => false
  end
end

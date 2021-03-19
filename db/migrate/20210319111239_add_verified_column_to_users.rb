class AddVerifiedColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :verified, :boolean, default: true
  end
end

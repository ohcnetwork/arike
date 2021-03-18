class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string
    add_column :users, :phone, :bigint
    add_column :users, :password_digest, :string
    add_index :users, [:email, :phone], :unique => true
  end
end

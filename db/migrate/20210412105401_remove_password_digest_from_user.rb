class RemovePasswordDigestFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password_digest
  end
end

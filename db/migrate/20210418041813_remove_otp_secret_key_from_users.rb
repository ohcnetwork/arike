class RemoveOtpSecretKeyFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :otp_secret_key
  end
end

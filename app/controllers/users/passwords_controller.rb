# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  def after_resetting_password_path_for(resource)
    new_user_session_path
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    new_user_session_path
  end
end

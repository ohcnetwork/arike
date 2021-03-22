class PasswordResetController < ApplicationController
  def index
    # TODO: Render a Template which has a email field
  end

  def verify
    # TODO: Render a Template which has new password and confirm password fields
  end

  def forgot
    #  TODO: generate password reset token
    puts params[:email] == "X"
    redirect_to password_reset_url
  end
 
  def reset
    #  TODO: verify and update password reset token
  end
end

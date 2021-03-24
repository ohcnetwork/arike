class SessionMailer < ApplicationMailer
  def password_reset
    mail to: params[:email]
  end

  # Other Emails regarding Sessions like Welcome Email, Verification Email goes here

end

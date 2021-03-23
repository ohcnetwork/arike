class SessionMailer < ApplicationMailer

  def password_reset
    @token = params[:user].signed_id(expires_in: 15.minutes, purpose: "password_reset")
    mail to: params[:user].email
  end

  # Other Emails regarding Sessions like Welcome Email, Verification Email goes here
  
end


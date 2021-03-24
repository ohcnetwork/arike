class PasswordResetController < ApplicationController
  def index
  end

  def options
    user_id = params[:user_id]

    is_email = URI::MailTo::EMAIL_REGEXP
    is_phone = /^(\+\d{1,3}[- ]?)?\d{10}$/

    user = nil
    if user_id =~ is_email
      user = User.find_by(email: user_id)
    elsif user_id =~ is_phone
      user = User.find_by(phone: user_id)
    end
    if user
      render "options", locals: { :user => user }
    else
      flash[:error] = "Invalid Email or Phone Number!"
      redirect_to password_reset_page_path
    end
  end

  def send_otp
    option = params[:option]
    user_id = params[:user_id]
    user = User.find_by(id: user_id)
    if user
      if option == "mail"
        send_otp_mail
        render "verify", locals: {}
      elsif option == "sms"
        send_otp_sms
        render "verify", locals: {}
      else
        flash[:error] = "Invalid Option!"
        redirect_to password_reset_page_path
      end
    else
      flash[:error] = "Invalid Email or Phone Number!"
      redirect_to password_reset_page_path
    end
  end

  def send_otp_sms
    puts "OTP SMS will be sent here!"
  end

  def send_otp_mail
    puts "OTP Email will be sent here!"
  end
end

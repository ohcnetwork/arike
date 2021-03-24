class PasswordResetController < ApplicationController
  def index
  end

  def options
    user_id = params[:user_id]

    is_email = URI::MailTo::EMAIL_REGEXP
    is_phone = /^(\+\d{1,3}[- ]?)?\d{10}$/

    @user = nil
    if user_id =~ is_email
      @user = User.find_by(email: user_id)
    elsif user_id =~ is_phone
      @user = User.find_by(phone: user_id)
    end
    if @user
      # email = user.email.gsub(/.{0,4}/, '####@')
      # phone = user.phone.to_s[0,1]+
      session[:password_reset_user_id] = @user.id
      render "options"
    else
      session[:password_reset_user_id] = nil
      flash[:error] = "Invalid Email or Phone Number!"
      redirect_to password_reset_page_path
    end
  end

  def send_otp
    option = params[:option]
    user_id = session[:password_reset_user_id]
    @user = User.find_by(id: user_id)

    if @user
      # valid for 5 min
      otp = @user.otp_code

      if option == "mail"
        send_otp_mail(@user.email, otp)
        render "verify"
      elsif option == "sms"
        send_otp_sms(@user.phone, otp)
        render "verify"
      else
        session[:password_reset_user_id] = nil
        flash[:error] = "Invalid Option!"
        redirect_to password_reset_page_path
      end
    else
      session[:password_reset_user_id] = nil
      flash[:error] = "Invalid Email or Phone Number!"
      redirect_to password_reset_page_path
    end
  end

  def send_otp_sms(phone, otp)
    User.send_sms(phone, "Here is your OTP: #{otp}")
  end

  def send_otp_mail(email, otp)
    SessionMailer.with(email: email, otp: otp).password_reset.deliver_later
  end

  def verify
    user_id = session[:password_reset_user_id]
    otp = params[:otp]
    @user = User.find_by(id: user_id)
    if @user
      # Default: 30 secs | Drift: 270 secs
      is_verified = @user.authenticate_otp(otp, drift: 270)
      if is_verified
        flash.now[:notice] = "OTP Verification Successful!"
        render "update"
      else
        flash.now[:error] = "Invalid OTP!"
        render "verify"
      end
    else
      session[:password_reset_user_id] = nil
      redirect_to home_path
    end
  end

  def update
    @user = User.find_by(id: session[:password_reset_user_id])
    new_password = params[:new_password]
    confirm_password = params[:confirm_password]
    if @user
      if new_password != confirm_password
        flash[:error] = "Your Password doesn't match!"
        render "update"
      else
        if @user.update(password: new_password)
          redirect_to home_path, notice: "Password Reset Successful! You can login now."
        else
          session[:password_reset_user_id] = nil
          flash[:error] = @user.errors.full_messages.to_sentence
          redirect_to home_path, notice: "Someting went wrong! Try again later!"
        end
      end
    else
      session[:password_reset_user_id] = nil
      redirect_to home_path
    end
  end
end

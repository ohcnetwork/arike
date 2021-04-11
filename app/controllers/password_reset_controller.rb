class PasswordResetController < ApplicationController
  layout "public"
  skip_before_action :authenticate_user!

  def index; end

  def send_otp
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
      @user.send_reset_password_instructions
      flash[:notice] = 'OTP has been sent to your email! Click on it to reset your password'
    else
      flash[:error] = 'Invalid Email or Phone Number!'
    end

    redirect_to password_reset_page_path
  end

  def verify
    user_id = session[:password_reset_user_id]
    otp = params[:otp]
    @user = User.find_by(id: user_id)
    if @user
      # Default: 30 secs | Drift: 270 secs
      is_verified = @user.authenticate_otp(otp, drift: 270)
      if is_verified
        flash.now[:notice] = 'OTP Verification Successful!'
        render 'update'
      else
        flash.now[:error] = 'Invalid OTP!'
        render 'verify'
      end
    else
      session[:password_reset_user_id] = nil
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(id: session[:password_reset_user_id])
    new_password = params[:new_password]
    confirm_password = params[:confirm_password]
    if @user
      if new_password != confirm_password
        flash[:error] = "Your Password doesn't match!"
        render 'update'
      else
        if @user.update(password: new_password)
          redirect_to root_path,
                      notice: 'Password Reset Successful! You can login now.'
        else
          session[:password_reset_user_id] = nil
          flash[:error] = @user.errors.full_messages.to_sentence
          redirect_to root_path, notice: 'Someting went wrong! Try again later!'
        end
      end
    else
      session[:password_reset_user_id] = nil
      redirect_to root_path
    end
  end
end

class PasswordResetController < ApplicationController
  def index
  end

  def verify
    @user = User.find_signed(params[:token], purpose: "password_reset")
    unless @user
      flash[:error] = "Your Token is invalid"
      redirect_to home_path
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    flash[:error] = "Your Token is invalid"
    redirect_to home_path
  end

  def send_mail
    @user = User.find_by(email: params[:email])
    if @user
      SessionMailer.with(user: @user).password_reset.deliver_now
    end
    redirect_to home_path, notice: "If an account with that email was found, we have sent a link to reset your password!"
  end

  def reset
    password = params[:user][:password]
    confirm_password = params[:user][:confirm_password]
    if password != confirm_password
      flash[:error] = "Your Password doesn't match!"
      redirect_to password_reset_verify_path(token: params[:token])
    else
      user = User.find_signed(params[:token], purpose: "password_reset")
      if user
        if user.update(password: password)
          redirect_to home_path, notice: "Password Reset Successful! You can login now."
        else
          flash[:error] = user.errors.full_messages.to_sentence
          redirect_to password_reset_verify_path(token: params[:token])
        end
      else
        flash[:error] = "Your token has been expired! Try resetting your password again!"
        redirect_to home_path
      end
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    flash[:error] = "Your Token is invalid"
    redirect_to home_path
  end
end

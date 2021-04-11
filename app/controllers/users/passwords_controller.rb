# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /users/password/new
  def new
    render "password_reset/index", layout: "public"
  end

  # POST /users/password
  def create
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

    redirect_back fallback_location: new_user_password_path
  end

  # GET /users/password/edit?reset_password_token=abcdef
  def edit
    @reset_password_token = params[:reset_password_token]
    render "password_reset/update", layout: "public"
  end

  # PUT /users/password
  def update
    user = User.reset_password_by_token({
     :reset_password_token => params[:reset_password_token],
     :password => params[:password],
     :password_confirmation => params[:password_confirmation]
    })

    if user.errors.empty?
      flash[:notice] = "Password reset successfully performed"
      redirect_to new_user_session_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_back fallback_location: edit_user_password_path
    end
  end
end

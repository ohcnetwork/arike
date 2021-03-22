class SessionsController < ApplicationController
  # skip_before_action :ensure_logged_in

  # Login Page
  def index
    if current_user
      redirect_to dashboard_path
    end
    @user = User.new
  end

  # Signup Page
  def new
    if current_user
      redirect_to dashboard_path
    end
    @user = User.new
  end

  # Login User
  def create
    login_id = params[:user][:login_id]
    password = params[:user][:password]

    is_email = URI::MailTo::EMAIL_REGEXP
    is_phone = /^(\+\d{1,3}[- ]?)?\d{10}$/

    user = nil
    if login_id =~ is_email
      user = User.find_by(email: login_id)
    elsif login_id =~ is_phone
      user = User.find_by(phone: login_id)
    end
    if user
      if user.authenticate(password)
        if user[:verified]
          session[:current_user_id] = user.id
          redirect_to dashboard_path
        else
          flash[:error] = "Your account has not been verified yet!"
          redirect_to sessions_path
        end
      else
        flash[:error] = "Invalid Credentials!"
        redirect_to sessions_path
      end
    else
      flash[:error] = "Enter a Valid Login ID"
      redirect_to sessions_path
    end
  end

  # Signup User
  def signup
    user = params.require(:user).permit(:full_name, :first_name, :role, :email, :phone, :password, :verified)
    user[:verified] = false

    if !User::SIGNUP_ROLES.include?(user[:role])
      flash[:error] = "Invalid SignUp Role!"
      redirect_to new_session_path
    end

    if !user[:password] || user[:password].strip.empty?
      user[:password] = "arike"
    end

    user = User.new(user)

    if user.valid?
      user.save
      redirect_to sessions_path, notice: "You have successfully signed up!"
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to sessions_path, notice: "You've been logged out!"
  end
end

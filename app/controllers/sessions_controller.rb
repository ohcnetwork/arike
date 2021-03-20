class SessionsController < ApplicationController
  def new
    @user = User.new
  end

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
      if user.authenticate(password) && user[:verified]
        session[:current_user_id] = user.id
        redirect_to dashboard_path
      else
        flash[:error] = "Invalid Credentials!"
        redirect_to new_session_path
      end
    else
      flash[:error] = "Enter a Valid Login ID"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to new_session_path
  end
end

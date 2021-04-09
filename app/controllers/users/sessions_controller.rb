# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @user = User.new
    render "sessions/new", layout: "public"
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

    sign_in(:user, user)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login_id])
  end
end

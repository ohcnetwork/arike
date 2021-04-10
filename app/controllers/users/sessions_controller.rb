# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    render "sessions/new", layout: "public"
  end

  def create
    login_id = params[:login_id]

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
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:login_id, :password)
    end
  end

  def after_sign_in_path_for(resource)
    redirect_to dashboard_path
  end
end

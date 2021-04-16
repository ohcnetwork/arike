# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def sign_up(_name, _resource)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :full_name, :role, :phone, :email])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    dashboard_path
  end
end

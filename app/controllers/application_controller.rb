class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery
  before_action :authenticate_user!
  before_action :ensure_verified_user!

  def ensure_verified_user!
    if user_signed_in?
      unless current_user.verified
        flash[:alert] = "Your account is not verified!"
        sign_out current_user
        redirect_to root_path
      end
    end
  end

  def ensure_superuser
    redirect_to root_path unless current_user.superuser?
  end

  def ensure_facility_access
    redirect_to root_path unless current_user.facility_access?
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized"
    redirect_to(request.referer || root_path)
  end
end

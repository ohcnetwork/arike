class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  def ensure_superuser
    redirect_to root_path unless current_user && current_user.superuser?
  end

  def ensure_facility_access
    unless current_user && current_user.facility_access?
      redirect_to root_path
    end
  end

  private

  def user_not_authorized
    flash[:error] = "You are not authorized"
    redirect_to(request.referer || root_path)
  end
end

class ApplicationController < ActionController::Base
  include Pundit
  # Commenting for the time being to avoid problems in other workflows
  # before_action :ensure_logged_in
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def ensure_logged_in
    unless current_user
      redirect_to home_path
    end
  end

  def ensure_superuser
    unless current_user && current_user.superuser?
      redirect_to home_path
    end
  end

  def ensure_facility_access
    unless current_user && current_user.has_facility_access?
      redirect_to home_path
    end
  end

  def current_user
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end

  private

  def user_not_authorized
    flash[:error] = "You are not authorized"
    redirect_to(request.referrer || home_path)
  end
end

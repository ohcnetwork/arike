class HomeController < ApplicationController
  skip_before_action :ensure_logged_in
  layout 'public'

  def index
    redirect_to dashboard_path if current_user
  end
end

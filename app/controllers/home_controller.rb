class HomeController < ApplicationController
  layout "public"

  def index
    redirect_to dashboard_path if current_user
  end
end

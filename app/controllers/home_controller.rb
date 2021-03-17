class HomeController < ApplicationController
  def index
  end

  def auto
    render "utils/autocomplete"
  end
end

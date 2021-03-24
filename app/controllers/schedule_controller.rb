class ScheduleController < ApplicationController
  def index
    @visits = Visit.all
  end
end

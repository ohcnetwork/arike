class ScheduleController < ApplicationController
  def index
    @visits = Visit.all
  end

  def update
    visit = Visit.find_by_id(params[:visit_id])
    visit.next_visit = params[:next_visit]
    visit.save
    redirect_to schedule_path
  end
end

class ScheduleController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @unscheduled_visits = Visit.unscheduled_visits
  end

  def schedule
    puts params
    # visit = Visit.find_by_id(params[:visit_id])
    # visit.next_visit = params[:next_visit]
    # visit.save
    redirect_to schedule_path
  end
end

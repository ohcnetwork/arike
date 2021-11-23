class ScheduleController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @unscheduled_patients = Visit.unscheduled_patients
  end

  def schedule
    date = params[:date]
    patient_ids = params[:patients]
    patient_ids.each { |patient_id| Visit.schedule(patient_id, date) }
  end

  def unschedule
    patient_id = params[:patient]
    Visit.unschedule(patient_id)
    redirect_to agenda_path
  end
end

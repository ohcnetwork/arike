class PatientDiseaseSummariesController < ApplicationController
  def index
    @patient = Patient.find_by_id(params[:patient_id])
    puts "Params are "
    puts params
    puts "patient is "
    puts @patient
    render "patients/disease_history/disease_history"
  end
end

class PatientDiseaseSummariesController < ApplicationController
  def index
    @patient = Patient.find_by_id(params[:id])
    puts "Params are "
    puts params
    puts "patient is "
    puts @patient
    render "patients/disease_history/disease_history"
  end

  def update
    @patient = Patient.find_by_id(params[:id])
    puts "params are "
    puts params
    @patient.update_disease_history(params[:patientDiseases], params[:id])
    # redirect_back fallback_location: "/"
    redirect_to patient_path
  end
end

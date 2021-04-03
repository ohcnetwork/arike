class PatientDiseaseSummariesController < ApplicationController
  def index
    @patient = Patient.find_by_id(params[:id])
    render "patients/disease_history/form"
  end

  def update
    @patient = Patient.find_by_id(params[:id])
    @patient.update_disease_history(params[:patientDiseases], params[:id])
    redirect_to patient_path
  end
end

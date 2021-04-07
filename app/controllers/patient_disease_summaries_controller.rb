class PatientDiseaseSummariesController < ApplicationController
  # GET /patients/:id/disease_history
  def index
    @patient = Patient.find_by(id: params[:id])
    render "patients/disease_history/form"
  end

  # PUT /patients/:id/patient_disease_summary/
  def update
    @patient = Patient.find_by(id: params[:id])
    @patient.update_disease_history(params[:patientDiseases], params[:id])
    redirect_to patient_path
  end
end

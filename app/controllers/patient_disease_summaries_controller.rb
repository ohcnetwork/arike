class PatientDiseaseSummariesController < ApplicationController
  def index
    @patient = Patient.find_by(id: params[:id])
    render "patients/disease_history/form"
  end

  def update
    @patient = Patient.find_by(id: params[:id])
    @patient.update_disease_history(params[:patientDiseases], params[:id])
    # Get patients/:id
    redirect_to patient_path
  end
end

class PatientDiseaseSummariesController < ApplicationController
  # GET /patients/:id/disease_history
  def index
    @patient = Patient.find_by(id: params[:patient_id])
    render "patients/disease_history/form"
  end

  # PUT /patients/:id/patient_disease_summary/
  def update
    @patient = Patient.find_by(id: params[:patient_id])
    @patient.update_disease_history(params[:patientDiseases], params[:patient_id])
    redirect_to patient_path(@patient)
  end
end

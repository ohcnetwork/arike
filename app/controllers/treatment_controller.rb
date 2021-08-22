class TreatmentController < ApplicationController
  # GET	/patients/:patient_id/treatment
  def new
    @patient = Patient.find_by(id: params[:patient_id])
    @treatments = Treatment.all
    render 'new'
  end

  # POST /patients/:patient_id/treatment
  def update
    patient = Patient.find_by(id: params[:patient_id])
    patient.add_treatments(params[:treatments])
    redirect_to patient_treatment_path(patient)
  end

  # PUT /patients/:patient_id/treatment/stop_treatment
  def stop_treatment
    patient = Patient.find_by(id: params[:patient_id])
    treatment = PatientTreatment.find_by(id: params[:treatment])
    treatment.update(stopped_at: Time.now)
    redirect_to patient_treatment_path(patient)
  end
end

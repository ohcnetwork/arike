class TreatmentController < ApplicationController
  def new
    @patient = Patient.find_by(id: params[:patient_id])
    @treatments = Treatment.all
    render 'new'
  end


  def update
    @patient = Patient.find_by(id: params[:patient_id])
    @patient.add_treatments(params[:treatments], params[:patient_id])
    redirect_to patient_path(@patient)
  end

  def create
    patient = Patient.find(params[:patient_id])
    patient.update(treatment: params[:treatment])

    if patient.save
      render json: []
    else
      render json: [error: patient.errors.full_messages.to_sentence]
    end
  end
end

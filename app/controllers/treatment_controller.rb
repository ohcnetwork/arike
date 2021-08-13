class TreatmentController < ApplicationController
  def new; end

  def index
    @patient = Patient.find_by(id: params[:patient_id])
    @treatments = Treatment.all
    render 'new'
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

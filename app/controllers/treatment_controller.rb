class TreatmentController < ApplicationController
  def new
  end

  def index
    treatments = Treatment.all
    render json: treatments
  end

  def create
    patient = Patient.find(params[:patient_id])
    patient.update(
      treatment: params[:treatment],
    )

    if patient.save
      render json: []
    else
      render json: [error: patient.errors.full_messages.to_sentence]
    end
  end
end

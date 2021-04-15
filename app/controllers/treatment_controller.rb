class TreatmentController < ApplicationController
  def new
  end

  def index
    treatments = Treatment.all
    render json: treatments.to_json
  end

  def create
    patient = Patient.find(params[:patient_id])
    patient.update(
      treatment: params[:treatment],
    )

    if patient.save
      render plain: "Treatments Updated Successfully"
    else
      render plain: patient.errors.full_messages.to_sentence
    end
  end
end

class TreatmentController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_logged_in

  def new
  end

  def index
    treatments = Treatment.all
    render json: treatments.to_json
  end

  def create
    patient = Patient.find(params[:id])
    patient.update(
      treatment: params[:treatment],
    )

    if patient.save
      render plain: "Treatments added"
    end
  end
end

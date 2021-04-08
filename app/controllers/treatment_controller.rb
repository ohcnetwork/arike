class TreatmentController < ApplicationController
  def new
  end

  def index
    treatments = Treatment.all
    render json: treatments.to_json
  end
end

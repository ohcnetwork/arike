class TreatmentController < ApplicationController
  def new
    @patient = Patient.find_by(id: params[:patient_id])
    @treatments = Treatment.all
    render 'new'
  end


  def update
    patient = Patient.find_by(id: params[:patient_id])

    # treatments = params[:treatments]
    render plain: params
    # params[:treatments].each do |treatment|
    #   Treatment.create(name: treatment.name, category: treatment.category)
    # end
    # redirect_to patient_treatment_path(params[:patient_id])
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

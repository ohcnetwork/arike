class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @patient = Patient.new
  end

  def create
    patient_params = params.require(:patient).permit(:full_name, :first_name, :dob, :address, :route, :phone, :economic_status, :notes, :asha_member)
    patient = Patient.create!(patient_params)
    User.addVolunteer(patient, params[:patient][:volunteer])
    redirect_to patients_path
  end

  def show
    @patient = Patient.find_by(id: params[:id])
  end

  def edit
  end

  def update
    patient = params.require(:patient).permit(:full_name, :first_name, :dob, :address, :route, :phone, :economic_status, :notes)
    @patient.update!(patient)
    redirect_to patients_path
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end
end

class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @patient = Patient.new
    render "/patients/personal_details/form", locals: { patient: @patient }
  end

  def create
    patient = Patient.create!(patient_params)
    volunteer = params[:patient].permit(:volunteer => {})
    volunteer_user_ids = volunteer[:volunteer].to_h.filter { |key, value| value == "on" }.map { |key, value| key }
    patient.add_users(volunteer_user_ids)
    redirect_to patients_path
  end

  def show
    @patient = Patient.find_by(id: params[:id])
  end

  def edit
    render "/patients/personal_details/form", locals: { patient: Patient.find_by_id(params[:id]) }
  end

  def update
    @patient.update!(patient_params)
    volunteer = params[:patient].permit(:volunteer => {})
    volunteer_user_ids = volunteer[:volunteer].to_h.filter { |key, value| value == "on" }.map { |key, value| key }
    @patient.update_users(volunteer_user_ids)
    redirect_to patient_path
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:full_name, :dob, :address, :route, :phone, :economic_status,
                                    :notes, :reported_by, :sex,
                                    :emergency_phone_no, :disease, :facility_id)
  end
end

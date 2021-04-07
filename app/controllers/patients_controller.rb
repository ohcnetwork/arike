class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update]

  # GET /patients/
  def index
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    render "/patients/personal_details/form", locals: { patient: @patient }
  end

  # POST /patients
  def create
    patient = Patient.create!(patient_params)
    volunteer = params[:patient].permit(:volunteer => {})
    volunteer_user_ids = volunteer[:volunteer].to_h.filter { |_key, value| value.to_i == 1 }.map { |key, _value| key }
    patient.add_users(volunteer_user_ids)
    # Get /patients
    redirect_to patients_path
  end

  # GET /patients/:id
  def show
    @patient = Patient.find_by(id: params[:id])
  end

  # GET /patients/:id/edit
  def edit
    render "/patients/personal_details/form"
  end

  # PUT /patients/:id/
  def update
    @patient.update!(patient_params)
    volunteer = params[:patient].permit(:volunteer => {})
    volunteer_user_ids = volunteer[:volunteer].to_h.filter { |_, value| value == "on" }.map { |key, _| key }
    @patient.update_users(volunteer_user_ids)
    # Get patients/:id
    redirect_to patient_path
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:full_name, :dob, :address, :route, :phone, :economic_status,
                                    :notes, :sex,
                                    :emergency_phone_no, :disease, :facility_id)
  end
end

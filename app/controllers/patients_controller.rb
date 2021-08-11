class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update]

  # GET /patients/
  def index
    @search_text = params.fetch(:search, '')

    # filter and paginate
    @patients = filter_patients(@search_text)
    authorize Patient
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    authorize Patient
    render '/patients/personal_details/form'
  end

  # POST /patients
  def create
    authorize Patient
    @patient = Patient.create(patient_params)
    volunteer = params[:patient].permit(volunteer: {})
    volunteer_user_ids =
      volunteer[:volunteer].to_h.filter do |_, value|
        value == 'on'
      end.map { |key, _| key }
    @patient.add_users(volunteer_user_ids)
    if !@patient.valid?
      flash[:alert] = @patient.errors.full_messages.join(', ')
      redirect_to new_patient_path
      return
    end
    redirect_to patients_path
  end

  # GET /patients/:id
  def show
    authorize Patient
  end

  # GET /patients/:id/edit
  def edit
    authorize Patient
    render '/patients/personal_details/form'
  end

  def show_detail
    @patient = Patient.find_by(id: params[:patient_id])
    authorize Patient
    render 'show'
  end

  # PUT /patients/:id/
  def update
    authorize Patient
    @patient.update(patient_params)
    volunteer = params[:patient].permit(volunteer: {})
    volunteer_user_ids =
      volunteer[:volunteer].to_h.filter do |_, value|
        value == 'on'
      end.map { |key, _| key }
    @patient.update_users(volunteer_user_ids)
    if !@patient.valid?
      flash[:alert] = @patient.errors.full_messages.join(', ')
      redirect_to edit_patient_path
      return
    end
    redirect_to patient_path
  end

  def treatment_details
    patient = Patient.find(params[:id])
    render plain: patient.treatment
  end

  private

  def set_patient
    @patient = Patient.find_by(id: params[:id])
  end

  def patient_params
    params
      .require(:patient)
      .permit(
        :full_name,
        :dob,
        :address,
        :route,
        :phone,
        :economic_status,
        :notes,
        :gender,
        :emergency_phone_no,
        :disease,
        :facility_id,
      )
  end

  def filter_patients(search_text)
    policy_scope(Patient).where(
      'full_name ILIKE :search_text',
      search_text: "%#{search_text}%",
    )
  end
end

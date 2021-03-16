class PatientsController < ApplicationController
  def index
  end

  def new
    @patient = Patient.new
  end

  def create
    patient = params.require(:patient).permit(:full_name, :first_name, :dob, :address, :route, :phone, :economic_status, :notes)
    Patient.create!(patient)
    redirect_to patients_path
  end

  def show
    @patient = Patient.find_by(id: params[:id])
  end

  def edit
    @patient = Patient.find_by(id: params[:id])
  end

  def update
  end
end

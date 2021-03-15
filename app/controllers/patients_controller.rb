class PatientsController < ApplicationController
  def new
    @patient = Patient.new
  end

  def create
    patient = params.require(:patient).permit(:full_name, :first_name, :dob, :address, :route, :phone, :economic_status, :notes)
    Patient.create!(patient)
    redirect_to root_path
  end
end

class FamilyDetailsController < ApplicationController
  # GET /patients/:patient_id/family_details
  def index
    @patient = Patient.find_by(id: params[:patient_id])
    render "patients/family_tree/form"
  end

  # PUT /patients/:patient_id/family_details
  def update
    @patient = Patient.find_by(id: params[:patient_id])
    @patient.update_family_member(params[:familyDetails], params[:patient_id])
    redirect_to patient_path(@patient)
  end
end

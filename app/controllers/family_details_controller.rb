class FamilyDetailsController < ApplicationController
  # skip_before_action :ensure_logged_in

  # GET /patients/:patient_id/family_details
  def index
    @patient = Patient.find_by(id: params[:id])
    render "patients/family_tree/form"
  end

  # PUT /patients/:patient_id/family_details
  def update
    @patient = Patient.find_by(id: params[:id])
    @patient.update_family_member(params[:familyDetails], params[:id])
    # Get /patients/:id
    redirect_to patient_path
  end
end

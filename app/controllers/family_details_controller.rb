class FamilyDetailsController < ApplicationController
  # skip_before_action :ensure_logged_in

  # /patients/:patient_id/family_details
  def index
    @patient = Patient.find_by_id(params[:id])
    render "patients/family_tree/family_details"
  end

  def allMembers
    @familyMembers = FamilyDetail.all.where(patient_id: params[:id])
    render "patients/family_tree/index"
  end

  def update
    @patient = Patient.find_by_id(params[:id])
    @patient.update_family_member(params[:familyDetails], params[:id])
    # redirect_back fallback_location: "/"
    redirect_to patient_path
  end
end

class FamilyDetailsController < ApplicationController
  # skip_before_action :ensure_logged_in

  # /patients/:patient_id/family_details
  def index
    @patient = Patient.find_by_id(params[:id])
    render "patients/family_tree/family_details"
  end

  def update
  end
end

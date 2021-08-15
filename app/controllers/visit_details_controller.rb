class VisitDetailsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    visit =
      VisitDetail.new()

    if visit.save
      flash[:notice] = 'Successfully created visit'
      redirect_to new_visit_detail_path
    else
      flash[:alert] = visit.error.full_messages.join(', ')
      redirect_to new_visit_detail_path
    end
  end

  def new
    @visit = VisitDetail.create!(patient_id: params[:patient_id])
    @patient=Patient.find_by(id: params[:patient_id])
    redirect_to patient_visit_general_information_path(@patient,@visit)
  end

  def decision; end

  def expired; end

  def assign_to; end

  def schedule_revisit; end
end

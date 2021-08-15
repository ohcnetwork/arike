class PsychologicalReviewsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    @info = PsychologicalReview.find_by(visit_id: params[:visit_id])
    @patient=Patient.find_by(id: params[:patient_id])
    if @info.nil?
      @info = PsychologicalReview.new
      @info.visit_id = params[:visit_id]
    end
    render 'visit_details/new'
  end
  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    @patient=Patient.find_by(id: params[:patient_id])
    rec = PsychologicalReview.find_by(visit_id: params[:visit_id])
    if rec == nil
      new_rec = PsychologicalReview.create!(allowed_params)
      @visit.update(psychological_review_id: new_rec.id)
    else
      rec.update(allowed_params)
    end
    redirect_to patient_visit_physical_symptom_path(@patient,@visit)
  end
  def allowed_params
    params.permit(
      :visit_id,
      :patient_worried,
      :family_anxious,
      :patient_depressed,
      :patient_feels,
      :patient_informed,
    )
  end
end

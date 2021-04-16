class PsychologicalReviewsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    render "visit_details/pa_new"
  end
  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    rec = PsychologicalReview.find_by(visit_id: params[:visit_id])
    if rec == nil
      new_rec = PsychologicalReview.create!(allowed_params)
      @visit.update(psychological_review_id: new_rec.id)
    else
      rec.update(allowed_params)
    end
    redirect_to visit_physical_symptom_path(@visit)
  end
  def allowed_params
    params.permit(:visit_id, :patient_worried, :family_anxious,
       :patient_depressed, :patient_feels, :patient_informed)
  end
end

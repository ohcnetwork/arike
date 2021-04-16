class PhysicalExaminationsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    render "visit_details/pa_new"
  end

  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    rec = PhysicalExamination.find_by(visit_id: params[:visit_id])
    if rec == nil
      new_rec = PhysicalExamination.create!(allowed_params)
      @visit.update(physical_examination_id: new_rec.id)
    else
      rec.update(allowed_params)
    end
    redirect_to root_path
  end
  def allowed_params
    params.permit(:visit_id, :bp, :grbs, :rr, :pulse, :personal_hygiene,
    :mouth_hygiene, :pubic_hygiene, :systemic_examination,
  :systemic_examination_details)
  end
end

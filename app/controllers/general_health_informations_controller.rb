class GeneralHealthInformationsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    @info = GeneralHealthInformation.find_by(visit_id: params[:visit_id])
    render "visit_details/pa_new"
  end

  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    rec = GeneralHealthInformation.find_by(visit_id: params[:visit_id])
    if rec == nil
      new_rec = GeneralHealthInformation.create!(allowed_params)
      @visit.update(general_health_information_id: new_rec.id)
    else
      rec.update(allowed_params)
    end
    redirect_to visit_psychological_review_path(@visit)
  end

  def allowed_params
    params.permit(:visit_id, :akps, :palliative_phase)
  end
end

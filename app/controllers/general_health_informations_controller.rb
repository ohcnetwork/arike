class GeneralHealthInformationsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    render "visit_details/pa_new"
  end

  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    puts "General Info Params are "
    puts params
    redirect_to visit_psychological_review_path(@visit)
  end
end

class PhysicalExaminationsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    render "visit_details/pa_new"
  end

  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    puts "Physical Examniation Info Params are "
    puts params
    redirect_to root_path
  end
end

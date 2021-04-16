class PhysicalSymptomsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    render "visit_details/pa_new"
  end

  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    puts "Physical Symptoms Info Params are "
    puts params
    redirect_to visit_physical_examination_path(@visit)
  end
end

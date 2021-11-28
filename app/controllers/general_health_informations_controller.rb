class GeneralHealthInformationsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    @info = GeneralHealthInformation.find_by(visit_id: params[:visit_id])
    @patient=Patient.find_by(id: params[:patient_id])
    if @info.nil?
      @info = GeneralHealthInformation.new
      @info.visit_id = params[:visit_id]
    end
    render 'visit_details/new'
  end

  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    rec = GeneralHealthInformation.find_by(visit_id: params[:visit_id])
    @patient=Patient.find_by(id: params[:patient_id])
    if rec == nil
      new_rec = GeneralHealthInformation.create!(allowed_params)
      @visit.update(general_health_information_id: new_rec.id)
    else
      rec.update(allowed_params)
    end
    redirect_to patient_visit_psychological_review_path(@patient,@visit)
  end

  def allowed_params
    params.permit(:visit_id, :akps, :palliative_phase)
  end
end

class PhysicalExaminationsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    @info = PhysicalExamination.find_by(visit_id: params[:visit_id])
    @patient = Patient.find_by(id: params[:patient_id])
    if @info.nil?
      @info = PhysicalExamination.new
      @info.visit_id = params[:visit_id]
    end
    render 'visit_details/new'
  end

  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    @patient = Patient.find_by(id: params[:patient_id])
    rec = PhysicalExamination.find_by(visit_id: params[:visit_id])
    if rec == nil
      new_rec = PhysicalExamination.create!(allowed_params)
      @visit.update(physical_examination_id: new_rec.id)
    else
      rec.update(allowed_params)
    end
    redirect_to patient_treatment_new_path
  end

  def allowed_params
    params.permit(
      :visit_id,
      :bp,
      :grbs,
      :rr,
      :pulse,
      :personal_hygiene,
      :mouth_hygiene,
      :pubic_hygiene,
      :systemic_examination,
      :systemic_examination_details,
    )
  end
end

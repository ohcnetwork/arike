class PhysicalSymptomsController < ApplicationController
  def new
    @visit = VisitDetail.find_by(id: params[:visit_id])
    @info = PhysicalSymptom.find_by(visit_id: params[:visit_id])
    if @info.nil?
      @info = PhysicalSymptom.new
      @info.visit_id = params[:visit_id]
    end
    render 'visit_details/pa_new'
  end

  def create
    @visit = VisitDetail.find_by(id: params[:visit_id])
    rec = PhysicalSymptom.find_by(visit_id: params[:visit_id])
    if rec == nil
      new_rec = PhysicalSymptom.create!(allowed_params)
      @visit.update(physical_symptoms_id: new_rec.id)
    else
      rec.update(allowed_params)
    end
    redirect_to visit_physical_examination_path(@visit)
  end
  def allowed_params
    params.permit(
      :visit_id,
      :patient_at_peace,
      :pain,
      :shortness_breath,
      :weakness,
      :poor_mobility,
      :nausea,
      :vomiting,
      :poor_appetite,
      :constipation,
      :sore,
      :drowsiness,
      :wound,
      :lack_of_sleep,
      :micnutrition,
      :other_symptoms,
    )
  end
end

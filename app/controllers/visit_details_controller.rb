class VisitDetailsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @patient = Patient.find_by(id: params[:patient_id])
    @visits = VisitDetail.all.where(patient_id: params[:patient_id]).reverse()
    render "index"
  end

  def create
    visit =
      VisitDetail.new()

    if visit.save
      flash[:notice] = 'Successfully created visit'
      redirect_to new_visit_detail_path
    else
      flash[:alert] = visit.error.full_messages.join(', ')
      redirect_to new_visit_detail_path
    end
  end

  def new
    @visit = VisitDetail.create!(patient_id: params[:patient_id])
    @patient=Patient.find_by(id: params[:patient_id])
    redirect_to patient_visit_general_information_path(@patient,@visit)
  end

  def show
    @general_health_information = GeneralHealthInformation.find_by(visit_id: params[:id])
    @physical_symptom = PhysicalSymptom.find_by(visit_id: params[:id])
    @physical_examination = PhysicalExamination.find_by(visit_id: params[:id])
    @psychological_review = PsychologicalReview.find_by(visit_id: params[:id])

    puts "General Health Info"
    puts @general_health_information

    puts "Physical Symptom"
    puts @physical_symptom

    puts "Physical Examination"
    puts @physical_examination

    puts "Psychological"
    puts @psychological_review

    render "show"
  end

  def decision; end

  def expired; end

  def assign_to; end

  def schedule_revisit; end
end

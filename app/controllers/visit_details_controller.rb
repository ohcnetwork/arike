class VisitDetailsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    visit = VisitDetail.new(
      akps: Integer(params[:akps]),
      disease_history_changed: params[:disease_history_changed],
      palliative_phase: params[:palliative_phase],
      patient_worried: params[:patient_worried],
      family_anxious: params[:family_anxious],
      patient_depressed: params[:patient_depressed],
      patient_feels: params[:patient_feels],
      patient_informed: params[:patient_informed],
      patient_at_peace: params[:patient_at_peace],
      pain: params[:pain],
      shortness_breath: params[:shortness_breath],
      weakness: params[:weakness],
      poor_mobility: params[:poor_mobility],
      nausea: params[:nausea],
      vomiting: params[:vomiting],
      poor_appetite: params[:poor_appetite],
      constipation: params[:constipation],
      sore: params[:sore],
      drowsiness: params[:drowsiness],
      wound: params[:wound],
      lack_of_sleep: params[:lack_of_sleep],
      micturition: params[:micturition],
      other_symptoms: params[:other_symptoms],
      bp: params[:bp],
      grbs: params[:grbs],
      rr: params[:rr],
      pulse: params[:pulse],
      personal_hygiene: params[:personal_hygiene],
      mouth_hygiene: params[:mouth_hygiene],
      pubic_hygiene: params[:pubic_hygiene],
      systemic_examination: params[:systemic_examination],
      done_by: params[:done_by]
    )

    if visit.save
      flash[:success] = "Successfully created visit"
      redirect_to new_visit_detail_path
    else
      flash[:error] = visit.error.full_messages.join(", ")
      redirect_to new_visit_detail_path
    end
  end

  def new
  end

  def pa_new
    render "pa_new"
  end

  def decision
  end

  def expired
  end

  def assign_to
  end

  def schedule_revisit
  end

end

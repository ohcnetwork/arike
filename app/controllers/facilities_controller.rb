class FacilitiesController < ApplicationController
  before_action :set_facility, only: %i[edit update show_users show_patients]

  # GET /facilities/
  def index
    @page = params.fetch(:page, 1).to_i
    @search_text = params.fetch(:search, '')

    # filter and paginate
    @facilities = filter_facilities(@search_text, @page)
    authorize Facility
  end

  # GET /facilities/:id
  def show
    @facility = policy_scope(Facility).find(params[:id])
    authorize @facility, :show?
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
    authorize @facility
  end

  # POST /facilities
  def create
    facility = Facility.create(facilities_params)
    user_saved =
      if !current_user.superuser?
        user = User.add_to_facility(current_user.id, facility.id)
        user.save
      else
        true
      end

    if facility.errors.empty? && user_saved
      redirect_to facility_path(facility.id),
                  notice: 'You have successfully created a facility!'
    else
      flash[:error] = facility.errors.full_messages.to_sentence
      redirect_to new_facility_path
    end
  end

  # GET /facilities/:id/edit
  def edit; end

  # PATCH /facilities/:id
  def update
    @facility.update!(facilities_params)
    redirect_to facility_path(@facility.id)
  end

  # GET /facilities/:id/users
  def show_users
    authorize @facility
  end

  # GET /facilities/:id/patients
  def show_patients
    authorize @facility
  end

  # GET /facilities/get_districts_of_state/:state_id
  def get_districts_of_state
    state_id = params[:state_id]
    @districts = state_id ? State.find(state_id).districts : []
    respond_to { |format| format.json { render json: @districts } }
  end

  # GET facilities/get_wards_of_lsg_body/:lsg_body_id
  def get_wards_of_lsg_body
    lsg_body_id = params[:lsg_body_id]
    @wards = lsg_body_id ? LsgBody.find(lsg_body_id).wards : []
    respond_to { |format| format.json { render json: @wards } }
  end

  private

  def set_facility
    @facility = policy_scope(Facility).find(params[:id])
  end

  def facilities_params
    params
      .require(:facility)
      .permit(
        :kind,
        :name,
        :state_id,
        :district_id,
        :lsg_body_id,
        :ward_id,
        :address,
        :pincode,
        :phone,
        :parent_id,
      )
  end

  def filter_facilities(search_text, page)
    policy_scope(Facility)
      .where('name ILIKE :search_text', search_text: "%#{search_text}%")
      .page(page)
  end
end

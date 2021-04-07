class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:edit, :update, :show_users, :show_patients]

  # GET /facilities/
  def index
    @page = params.fetch(:page, 1).to_i
    @search_text = params.fetch(:search, "")
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
    facility_params = facilities_params
    if facility_params[:kind] == "CHC"
      facility_params[:parent_id] = nil
    end

    facility = Facility.create(facility_params)
    user_saved = if !current_user.superuser?
        user = User.add_to_facility(current_user.id, facility.id)
        user.save
      else
        true
      end

    if facility.errors.empty? && user_saved
      redirect_to facility_path(facility.id), notice: "You have successfully created a facility!"
    else
      flash[:error] = facility.errors.full_messages.to_sentence
      redirect_to new_facility_path
    end
  end

  # GET /facilities/:id/edit
  def edit
  end

  # PATCH /facilities/:id
  def update
    facility_params = facilities_params
    if facility_params[:kind] == "CHC"
      facility_params[:parent_id] = nil
    end
    @facility.update!(facility_params)
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

  private

  def set_facility
    @facility = policy_scope(Facility).find(params[:id])
  end

  def facilities_params
    params.require(:facility).permit(:kind, :name, :state, :district, :lsg_body_id, :ward_id, :address, :pincode, :phone, :parent_id)
  end

  def filter_facilities(search_text, page)
    policy_scope(Facility).where("name ILIKE :search_text", search_text: "%#{search_text}%").page(page)
  end
end

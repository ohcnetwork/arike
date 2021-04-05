class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:edit, :update, :show_users, :show_patients]

  # GET /facilities/
  def index
    @page = params.fetch(:page, 1).to_i
    @search_text = params.fetch(:search, "")
    @secondary_facilities = filter_facilities(@total_pages, @search_text, @page)
    authorize Facility
  end

  # GET /facilities/:id
  def show
    @facility = policy_scope(Facility).find_by_id(params[:id])
    authorize @facility, :show?
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
    authorize @facility
  end

  # POST /facilities
  def create
    if facilities_params[:kind] == "CHC"
      facilities_params[:parent_id] = nil
    end

    facility = Facility.create(facilities_params)
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
    result = @facility.update!(facilities_params)
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
    @facility = policy_scope(Facility).find_by_id(params[:id])
  end

  def facilities_params
    params.require(:facility).permit(:kind, :name, :state, :district, :lsg_body_id, :ward_id, :address, :pincode, :phone, :parent_id)
  end

  def filter_facilities(total_pages, search_text, page)
    @CARDS_PER_PAGE = 8
    filtered_facilities = policy_scope(Facility).where("name ILIKE :search_text", search_text: "%#{search_text}%")
    @facilities_count = filtered_facilities.count
    @total_pages = (filtered_facilities.count * 1.0 / @CARDS_PER_PAGE).ceil()
    # keep the pages within a limit
    @page = constraint(page, @total_pages, 1)
    @secondary_facilities = filtered_facilities.offset(@CARDS_PER_PAGE * (@page - 1)).limit(@CARDS_PER_PAGE)
    @secondary_facilities
  end

  def constraint(number, upper_bound, lower_bound)
    if upper_bound < lower_bound
      number = 1
    elsif number > upper_bound
      number = upper_bound
    elsif number < lower_bound
      number = lower_bound
    end
    number
  end
end

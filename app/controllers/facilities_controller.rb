class FacilitiesController < ApplicationController
  # before_action :ensure_facility_access, only: [:show, :new, :create]
  # before_action :ensure_superuser, only: [:index]
  before_action :set_facility, only: [:edit, :update, :show_users, :show_patients]

  def index
    @page = params.fetch(:page, 0).to_i
    @search_text = params.fetch(:search, "")
    @secondary_facilities = paginate_facilites(@page)

    authorize Facility
  end

  def show
    @facility = Facility.find_by(id: params[:id])
    authorize @facility
  end

  def new
    @facility = Facility.new
    authorize @facility
  end

  def create
    facility_params = params.require(:facility).permit(:kind, :name, :state, :district, :lsg_body_id, :ward_id, :address, :pincode, :phone, :parent_id)
    # facility
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

  def edit
  end

  def update
    result = @facility.update!(facilities_params)
    redirect_to facility_path(@facility.id)
  end

  def show_users
  end

  def show_patients
  end

  private

  def set_facility
    @facility = Facility.find(params[:id])
  end

  def facilities_params
    params.require(:facility).permit(:kind, :name, :state, :district, :lsg_body, :ward, :address, :pincode, :phone, :parent_id)
  end

  private

  def paginate_facilites(page)
    @CARDS_PER_PAGE = 8
    @total_pages = (policy_scope(Facility).count * 1.0 / @CARDS_PER_PAGE).ceil()
    @secondary_facilities = policy_scope(Facility).offset(@CARDS_PER_PAGE * ((page == 0) ? 0 : page - 1)).limit(@CARDS_PER_PAGE)
    @secondary_facilities
  end

  def filter_facilities(search_text)
    Facility.where("name LIKE :search_text", search_text: "%#{search_text}%")
  end
end

# see all the secondary facilites -> superuser #index
# details of a single seconda facility, and all PFs under it -> secondary, superuser #show
# details of a primary facility -> primary, secondary user of that PF, superuser

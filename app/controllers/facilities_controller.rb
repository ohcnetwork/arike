class FacilitiesController < ApplicationController
  before_action :ensure_facility_access, only: [:show, :new, :create]
  before_action :ensure_superuser, only: [:index]
  before_action :set_facility, only: [:edit, :update, :show_users]

  def index
    @secondary_facilities = Facility.secondary_facilities
  end

  def show
    @facility = Facility.find_by_id(params[:id])
  end

  def new
    @facility = Facility.new
  end

  def create
    facility_params = params.require(:facility).permit(:kind, :name, :state, :district, :lsg_body, :ward, :address, :pincode, :phone, :parent_id)
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

  def set_facility
    @facility = Facility.find(params[:id])
  end

  def facilities_params
    params.require(:facility).permit(:kind, :name, :state, :district, :lsg_body, :ward, :address, :pincode, :phone, :parent_id)
  end
end

# see all the secondary facilites -> superuser #index
# details of a single seconda facility, and all PFs under it -> secondary, superuser #show
# details of a primary facility -> primary, secondary user of that PF, superuser

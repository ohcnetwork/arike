class FacilitiesController < ApplicationController
  before_action :ensure_facility_access
  before_action :ensure_superuser, only: [:index]

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
    if facility.errors.empty?
      redirect_to facility_path(facility.id), notice: "You have successfully created a facility!"
    else
      flash[:error] = facility.errors.full_messages.to_sentence
      redirect_to new_facility_path
    end
  end
end

# see all the secondary facilites -> superuser #index
# details of a single seconda facility, and all PFs under it -> secondary, superuser #show
# details of a primary facility -> primary, secondary user of that PF, superuser

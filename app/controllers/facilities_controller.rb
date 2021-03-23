class FacilitiesController < ApplicationController
  before_action :ensure_facility_access
  before_action :ensure_superuser, only: [:index]

  def index
    @secondary_facilities = Facility.secondary_facilities
  end

  def show
    # assuming it is a secondary
    @facility = Facility.find_by_id(params[:id])
  end
end

# see all the secondary facilites -> superuser #index
# details of a single seconda facility, and all PFs under it -> secondary, superuser #show
# details of a primary facility -> primary, secondary user of that PF, superuser
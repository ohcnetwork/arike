class FacilitiesController < ApplicationController
  before_action :ensure_facility_access
  before_action :ensure_superuser, only: [:index]

  def index
    @secondary_facilities = Facility.secondary_facilities
  end
end

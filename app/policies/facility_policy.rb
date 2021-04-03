class FacilityPolicy < ApplicationPolicy
  def index?
    # also do for MO
    user && (user.superuser? || user.secondary_nurse?)
  end

  def show?
    user && user.has_facility_access?
  end

  def new?
    user && user.has_facility_access?
  end

  def create?
    user && user.has_facility_access?
  end

  class Scope < Scope
    def resolve
      if user.superuser?
        Facility.all
      elsif user.nurse?
        Facility.where(id: user.facility_id)
      end
    end
  end
end

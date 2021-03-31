class FacilityPolicy < ApplicationPolicy
  def index?
    user && user.superuser?
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
      end
    end
  end
end

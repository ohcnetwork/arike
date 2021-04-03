class FacilityPolicy < ApplicationPolicy
  def index?
    # also do for MO
    user && (user.superuser? || user.secondary_nurse? || user.medical_officer?)
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

  def assign_facility?
    if user
      if user.superuser?
        return true
      elsif user.medical_officer?
        return user.facility.id == record.id
      else
        return false
      end
    else
      return false
    end
    # binding.pry
    # return true
  end

  def unassign_facility?
    if user
      if user.superuser?
        return true
      elsif user.medical_officer?
        return user.facility.id == record.id
      else
        return false
      end
    else
      return false
    end
  end

  class Scope < Scope
    def resolve
      if (user.superuser? || user.medical_officer?)
        Facility.all
      elsif user.nurse?
        Facility.where(id: user.facility_id)
      end
    end
  end
end

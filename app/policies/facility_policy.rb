class FacilityPolicy < ApplicationPolicy
  def index?
    user && (user.superuser? || user.secondary_nurse? || user.medical_officer?)
  end

  def show?
    user && (user.superuser? || user.facility_id == record.id)
  end

  def new?
    user && user.superuser?
  end

  def create?
    user && user.superuser?
  end

  def show_users?
    user && (user.superuser? || user.facility_id == record.id)
  end

  def show_patients?
    user && (user.superuser? || user.facility_id == record.id)
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
        Facility.where(id: user.facility_id).or(Facility.where(parent_id: user.facility_id))
      end
    end
  end
end

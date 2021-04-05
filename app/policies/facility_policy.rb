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

  alias create? new?

  def show_users?
    user && (user.superuser? || user.facility_id == record.id)
  end

  alias show_patients? show_users?

  def assign_facility?
    return if user.blank?
    return true if user.superuser?
    return false unless user.medical_officer?
    user.facility.id == record.id
  end

  alias unassign_facility? assign_facility?

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

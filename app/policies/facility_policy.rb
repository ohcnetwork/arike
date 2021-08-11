class FacilityPolicy < ApplicationPolicy
  def index?
    user && (user.role.in? [User.roles[:superuser], User.roles[:secondary_nurse], User.roles[:primary_nurse], User.roles[:medical_officer]])
  end

  def show?
    user && record && (user.superuser? || user.facility_id == record.id || (record.id.in? user.facility.primary_facilities.map { |f| f.id }.to_a))
  end

  def new?
    user && user.superuser?
  end

  alias create? new?

  def edit?
    user && (user.superuser? || (user.medical_officer? && user.facility_id == record.id))
  end

  alias update? edit?

  def show_users?
    user && (user.superuser? || user.facility_id == record.id || (record.id.in? user.facility.primary_facilities.map { |f| f.id }.to_a))
  end

  alias show_patients? show_users?

  def assign_facility?
    return false if user.blank?

    return true if user.superuser?

    return false unless user.medical_officer?

    user.facility.id == record.id
  end

  def facility_owner?
    return true if user.superuser?

    record.id == user.facility_id
  end

  alias unassign_facility? assign_facility?

  class Scope < Scope
    def resolve
      return Facility.all if (user.superuser? || user.medical_officer?)

      return Facility.where(id: user.facility_id).or(Facility.where(parent_id: user.facility_id)) if user.secondary_nurse?

      return Facility.where(id: user.facility_id) if user.primary_nurse?

      Facility.none
    end
  end
end

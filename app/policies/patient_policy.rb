class PatientPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  alias create? new?

  class Scope < Scope
    def resolve
      return Patient.all if (user.superuser?)

      # CHC -> All PHCs
      all_facilities = Facility.where(id: user.facility.id).or(Facility.where(parent_id: user.facility.id))
      return Patient.joins(:facility).where(facilities: all_facilities) if user.secondary_nurse? || user.medical_officer?

      return user.facility.patients if user.primary_nurse?

      Patient.none
    end
  end
end

# Secondary Nurse or Medical Officer -> Join table for each facility and facility under it
#  Patient.joins(:facility).where(facilities: [user.facility.primary_facilities])

class UserPolicy < ApplicationPolicy
  def index?
    user && user.facility_access?
  end

  alias new? index?

  def edit?
    user && user.superuser?
  end

  alias update? edit?
  alias verify? edit?
end

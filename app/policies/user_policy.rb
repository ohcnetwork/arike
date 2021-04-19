class UserPolicy < ApplicationPolicy
  def index?
    user && user.superuser?
  end

  alias new? index?
  alias edit? index?
  alias update? index?
  alias verify? index?
end

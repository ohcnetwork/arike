class WardPolicy < ApplicationPolicy
  def index?
    user && user.superuser?
  end

  alias new? index?
  alias show? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias destroy? index?
end

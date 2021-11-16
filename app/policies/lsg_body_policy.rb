class LsgBodyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.superuser?
        scope.all
      else
        scope.where(archived: false)
      end
    end
  end

  def new?
    user && user.superuser?
  end

  alias create? new?
  alias update? new?
  alias edit? new?
  alias show? new?
  alias archive? new?
  alias unarchive? new?
end

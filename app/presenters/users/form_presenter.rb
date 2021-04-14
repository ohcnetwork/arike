module Users
  class FormPresenter < ::ApplicationPresenter
    def user_access
      if current_user.superuser?
        User.roles.values
      elsif current_user.secondary_nurse?
        [User.roles[:primary_nurse], User.roles[:asha], User.roles[:volunteer]]
      elsif current_user.primary_nurse?
        [User.roles[:asha], User.roles[:volunteer]]
      else
        []
      end
    end
  end
end

module Users
  class IndexPresenter < ::ApplicationPresenter

    def users_list
      unverified + verified
    end

    def unverified
      default_key = "presenters.users.index_presenter.users_list.unverified"
      if current_user.superuser?
        unverified = User.unverified.map{ |user| user.attributes.symbolize_keys }
        [{ title: I18n.t("#{default_key}.title"), users: unverified}]
      else
        []
      end
    end

    def verified
      default_key = "presenters.users.index_presenter.users_list.verified"
        [{ title: I18n.t("#{default_key}.title"), users: user_access, }]
    end

    def user_access
      if current_user.superuser?
        users = User.verified
      elsif current_user.secondary_nurse?
        users = (User.verified.nurses).or(User.verified.ashas).or(User.verified.volunteers)
      elsif current_user.primary_nurse?
        users = (User.verified.primary_nurses).or(User.verified.ashas).or(User.verified.volunteers)
      else
        users = (User.verified.ashas).or(User.verified.volunteers)
      end
      can_edit(users)
    end

    def can_edit(users)
      users.map do |user|
        if user.role == current_user.role
          user.attributes.symbolize_keys.update(can_edit: false)
        else
          user.attributes.symbolize_keys.update(can_edit: true)
        end
      end
    end
  end
end

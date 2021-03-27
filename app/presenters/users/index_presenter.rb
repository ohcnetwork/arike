module Users
  class IndexPresenter < ::ApplicationPresenter

    def users_list
      unverified + verified
    end

    def unverified
      default_key = "presenters.users.index_presenter.users_list.unverified"
      if current_user.superuser?
        [{ title: I18n.t("#{default_key}.title"), users: User.unverified}]
      else
        []
      end
    end

    def verified
      default_key = "presenters.users.index_presenter.users_list.verified"
        [{ title: I18n.t("#{default_key}.title"), users: user_access}]
    end

    def user_access
      if current_user.superuser?
        User.verified
      elsif current_user.nurse?
        (User.verified.nurses).or(User.verified.ashas).or(User.verified.volunteers)
      else
        (User.verified.ashas).or(User.verified.volunteers)
      end
    end
  end
end

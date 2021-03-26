module Users
  class IndexPresenter < ::ApplicationPresenter

    def users_list
      unverified + verified
    end

    def verified
      default_key = "presenters.users.index_presenter.users_list.verified"
      [{ title: I18n.t("#{default_key}.title"), users: User.verified}]
    end

    def unverified
      default_key = "presenters.users.index_presenter.users_list.unverified"
      if current_user.superuser?
        [{ title: I18n.t("#{default_key}.title"), users: User.unverified}]
      else
        []
      end
    end
  end
end

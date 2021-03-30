module Users
  class IndexPresenter < ::ApplicationPresenter

    def user_sections
      unverified + verified
    end

    def user_section(key, users)
      default_key = "presenters.users.index_presenter.user_sections.#{key}"
      [{ title: I18n.t("#{default_key}.title"), users: users }]
    end

    def unverified
      if current_user.superuser?
        users = user_parse(User.unverified)
        user_section("unverified", users)
      else
        []
      end
    end

    def verified
      user_section("verified", user_access)
    end

    def user_access
      users =
        if current_user.superuser?
          User.verified
        elsif current_user.secondary_nurse?
          (User.verified.nurses).or(User.verified.ashas).or(User.verified.volunteers)
        elsif current_user.primary_nurse?
          (User.verified.primary_nurses).or(User.verified.ashas).or(User.verified.volunteers)
        else
          (User.verified.ashas).or(User.verified.volunteers)
        end

      user_parse(users)
    end

    def user_parse(users)
      users.map do |user|
        user = user.attributes.symbolize_keys
        if user[:role] == current_user.role
          user.update(can_edit: false)
        else
          user.update(can_edit: true)
        end
      end
    end
  end
end

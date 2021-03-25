module Dashboard
  class IndexPresenter < ::ApplicationPresenter

    def links
      schedule + visit + enroll_patients + calendar + new_users + account_settings + facilities + lsg_body
    end

    def link(key, path)
      default_key = "presenters.dashboard.index_presenter.links.#{key}"
      { title: I18n.t("#{default_key}.title"), text: I18n.t("#{default_key}.text"), icon: I18n.t("#{default_key}.icon"), link: path }
    end

    def schedule
      [link("schedule", view.schedule_path)]
    end

    def visit
      [link("visit", "")]
    end

    def enroll_patients
      [link("enroll_patients", view.new_patient_path)]
    end

    def calendar
      [link("calendar", view.schedule_path(anchor: "calender"))]
    end

    def new_users
      return [] unless current_user.role.in? [User.roles[:superuser]]
      [link("new_users", view.new_user_path)]
    end

    def account_settings
      [link("account_settings", "")]
    end

    def facilities
      [link("facilities", view.facilities_path)]
    end

    def lsg_body
      return [] unless current_user.role.in? [User.roles[:superuser]]
      [link("lsg_body", view.lsg_bodies_path)]
    end
  end
end

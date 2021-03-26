module Dashboard
  class IndexPresenter < ::ApplicationPresenter

    def links
      schedule + visit + lsg + enroll_patients + patients + calendar + new_users + users + facilities + account_settings
    end

    def link(key, path)
      default_key = "presenters.dashboard.index_presenter.links.#{key}"
     { title: I18n.t("#{default_key}.title"), text: I18n.t("#{default_key}.text"), icon: I18n.t("#{default_key}.icon"), link: path }
    end

    def schedule
      [link("schedule", view.schedule_path)]

    end

    def visit
      [link("visit", view.schedule_path)]
    end

    def enroll_patients
      [link("enroll_patients", view.new_patient_path)]
    end

    def patients
      [link("patients", view.patients_path)]
    end

    def calendar
      # return [] unless current_user.role.in? [User.roles[:asha]]
      [link("calendar", view.schedule_path(anchor: "calender"))]
    end

    def lsg
      return [] unless current_user.role.in? [User.roles[:asha]]
      [link("lsg", view.lsg_bodies_path)]
    end

    def new_users
      return [] unless current_user.superuser?
      [link("new_users", view.new_user_path)]
    end

    def users
      return [] unless current_user.superuser?
      [link("users", view.users_path)]
    end

    def account_settings
      [link("account_settings", view.password_reset_page_path)]
    end

    def facilities
      if current_user.superuser?
        [link("facilities", view.facilities_path)]
      else
        id = current_user.facility.id
        if id
          [link("facilities", view.facility_path(id))]
        else
          []
        end
      end
    end

  end
end

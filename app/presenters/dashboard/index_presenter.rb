module Dashboard
  class IndexPresenter < ::ApplicationPresenter
    def links
      schedule + lsg_body + wards + patients +
        calendar + new_users + users + facilities + account_settings
    end

    def link(key, path)
      default_key = "presenters.dashboard.index_presenter.links.#{key}"
      {
        title: I18n.t("#{default_key}.title"),
        text: I18n.t("#{default_key}.text"),
        icon: I18n.t("#{default_key}.icon"),
        link: path,
      }
    end

    def schedule
      [link('schedule', view.schedule_path)]
    end

    def patients
      [link('patients', view.patients_path)]
    end

    def calendar
      [link('calendar', view.schedule_path(anchor: 'calender'))]
    end

    def new_users
      return [] unless current_user.superuser? or current_user.nurse?
      [link('new_users', view.new_user_path)]
    end

    def users
      # return [] unless current_user.superuser? or current_user.nurse?
      [link('users', view.users_path)]
    end

    def account_settings
      [link('account_settings', view.new_user_password_path)]
    end

    def facilities
      return [] unless current_user.facility.nil?
      [link('facilities', view.facilities_path)]
    end

    def lsg_body
      return [] unless current_user.superuser?
      [link('lsg_body', view.lsg_bodies_path)]
    end

    def wards
      return [] unless current_user.superuser?
      [link('wards', view.wards_path)]
    end
  end
end
